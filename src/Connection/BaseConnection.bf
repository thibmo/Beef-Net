using System;
using Beef_Net.Interfaces;

namespace Beef_Net.Connection
{
	abstract class BaseConnection : Component, IDirect, IServer, IClient
	{
		public struct TimeVal
		{
			public int64 tv_sec;
			public int64 tv_usec;
		}

		protected TimeVal _timeVal;
		protected SocketEvent _onReceive;
		protected SocketEvent _onAccept;
		protected SocketEvent _onConnect;
		protected SocketEvent _onDisconnect;
		protected SocketEvent _onCanSend;
		protected SocketErrorEvent _onError;
		protected Socket _rootSock;
		protected Socket _iterator;
		protected int _id; // internal number for server
		protected Eventer _eventer;
		protected Type _eventerClass;
		protected int64 _timeout;
		protected int32 _listenBacklog;
		protected bool _reuseAddress;
		protected Session _session;
		protected int32 _socketNet;
		protected Eventer.EventerErrorEvent _onEventerErrorDlg = new => EventerError ~ delete _;
		protected Socket.HandleEvent _onReadDlg = new => ReceiveAction ~ delete _;
		protected Socket.HandleEvent _onWriteDlg = new => SendAction ~ delete _;
		protected Socket.HandleErrorEvent _onSockErrorDlg = new => ErrorAction ~ delete _;

		public SocketErrorEvent OnError
		{
			get { return _onError; }
			set { _onError = value; }
		}

		public SocketEvent OnReceive
		{
			get { return _onReceive; }
			set { _onReceive = value; }
		}

		public SocketEvent OnDisconnect
		{
			get { return _onDisconnect; }
			set { _onDisconnect = value; }
		}

		public SocketEvent OnCanSend
		{
			get { return _onCanSend; }
			set { _onCanSend = value; }
		}

		public int Count
		{
			get { return GetCount(); }
		}

		public bool Connected
		{
			get { return GetConnected(); }
		}

		public int32 ListenBacklog
		{
			get { return _listenBacklog; }
			set { _listenBacklog = value; }
		}

		public Socket Iterator
		{
			get { return _iterator; }
		}

		public int64 Timeout
		{
			get { return GetTimeout(); }
			set { SetTimeout(value); }
		}

		public Eventer Eventer
		{
			get { return _eventer; }
			set { SetEventer(value); }
		}

		public Type EventerClass
		{
			get { return _eventerClass; }
			set { _eventerClass = value; }
		}

		public Session Session
		{
			get { return _session; }
			set { SetSession(value); }
		}

		public bool ReuseAddress
		{
			get { return _reuseAddress; }
			set { SetReuseAddress(value); }
		}

		public int32 SocketNet
		{
			get { return _socketNet; }
			set { SetSocketNet(value); }
		}

		protected virtual Socket InitSocket(Socket aSocket)
		{
			_active = true; // once we got a socket, we're considered active
			aSocket.OnRead = _onReadDlg;
			aSocket.OnWrite = _onWriteDlg;
			aSocket.OnError = _onSockErrorDlg;
			aSocket.ListenBacklog = _listenBacklog;
			aSocket.[Friend]_creator = _creator;
			aSocket.[Friend]_connection = this;
			aSocket.[Friend]_session = _session;

			if (_session != null)
				_session.InitHandle(aSocket);

			return aSocket;
		}
		
		protected abstract bool GetConnected();
		
		protected virtual int GetCount()
		{
			return 1;
		}
		
		protected int64 GetTimeout() =>
			_eventer != null ? _eventer.Timeout : _timeout;

		protected void SetTimeout(int64 aValue)
		{
			if (_eventer != null)
				_eventer.Timeout = aValue;

			_timeout = aValue;
		}

		protected void SetReuseAddress(bool aValue)
		{
			if (_rootSock == null || _rootSock.[Friend]_connectionStatus == .None)
				_reuseAddress = aValue;
		}

		protected void SetEventer(Eventer aValue)
		{
			if (_eventer != null)
				_eventer.DeleteRef();

			_eventer = aValue;
			_eventer.AddRef();
		}

		protected void SetSession(Session aSession)
		{
			if (_session == aSession)
				return;

			Runtime.Assert(!_active, "Cannot change session on active component");
			_session = aSession;

			if (_session != null)
			{
				// _session.FreeNotification(this); // Fok this
				_session.RegisterWithComponent(this);
			}
		}

		protected void SetSocketNet(int32 aValue)
		{
			Runtime.Assert(!GetConnected(), "Cannot set socket network on a connected system");
			_socketNet = aValue;
		}

		protected virtual void ConnectAction(Handle aSocket)
		{
		}

		protected virtual void AcceptAction(Handle aSocket)
		{
		}

		protected virtual void ReceiveAction(Handle aSocket)
		{
		}

		protected virtual void SendAction(Handle aSocket)
		{
			((Socket)aSocket).SetState(.CanSend);
			aSocket.IgnoreWrite = true;

			if (((Socket)aSocket).[Friend]_session != null)
			{
				((Socket)aSocket).[Friend]_session.SendEvent(aSocket);
			}
			else
			{
				CanSendEvent(aSocket);
			}
		}

		protected virtual void ErrorAction(Handle aSocket, StringView aMsg)
		{
		}

		protected virtual void ConnectEvent(Handle aSocket)
		{
			if (_onConnect != null)
				_onConnect((Socket)aSocket);
		}

		protected virtual void DisconnectEvent(Handle aSocket)
		{
			if (_onDisconnect != null)
				_onDisconnect((Socket)aSocket);
		}

		protected virtual void AcceptEvent(Handle aSocket)
		{
			if (_onAccept != null)
				_onAccept((Socket)aSocket);
		}

		protected virtual void ReceiveEvent(Handle aSocket)
		{
			if (_onReceive != null)
				_onReceive((Socket)aSocket);
		}

		protected virtual void CanSendEvent(Handle aSocket)
		{
			if (_onCanSend != null)
				_onCanSend((Socket)aSocket);
		}

		protected virtual void ErrorEvent(Handle aSocket, StringView aMsg)
		{
			if (_onError != null)
				_onError(aMsg, (Socket)aSocket);
		}

		protected void EventerError(StringView aMsg, Eventer aSender) =>
			ErrorEvent(null, aMsg);

		protected virtual void RegisterWithEventer()
		{
			if (_eventer == null)
			{
				_eventer = (Eventer)_eventerClass.CreateObject();
				_eventer.OnError = _onEventerErrorDlg;
			}
			
			if (_rootSock != null)
				_eventer.AddHandle(_rootSock);
			
			if (_eventer.Timeout == 0 && _timeout != 0)
			{
				_eventer.Timeout = _timeout;
			}
			else
			{
				_timeout = _eventer.Timeout;
			}
		}

		protected virtual void FreeSocks(bool aIndForced)
		{
			Socket tmp = _rootSock;
			SocketConnectionStatus sockState = .Connected | .Connecting | .Disconnecting;

			while (tmp != null)
			{
				Socket tmp2 = tmp;
				tmp = tmp.NextSock;

				// forced, already closed or server socket
				if (aIndForced || (!sockState.HasFlag(tmp2.ConnectionStatus)) || tmp2.SocketState.HasFlag(.ServerSocket))
				{
					delete tmp2;
				}
				else
				{
					tmp2.Disconnect(aIndForced);
				}
			}
		}

		public this(): base()
		{
			_host = "";
			_port = 0;
			_listenBacklog = DEFAULT_BACKLOG;
			_timeout = 0;
			SocketClass = typeof(Socket);
			_onReceive = null;
			_onError = null;
			_onDisconnect = null;
			_onCanSend = null;
			_onConnect = null;
			_onAccept = null;
			_timeVal.tv_sec = 0;
			_timeVal.tv_usec = 0;
			_iterator = null;
			_eventer = null;
			_eventerClass = BestEventerClass();
		}

		public ~this()
		{
			FreeSocks(true);

			if (_eventer != null)
				_eventer.DeleteRef();
		}

		public ref Socket Socks(int aIdx)
		{
			Socket result = null;
			Socket tmp = _rootSock;
			int jumps = 0;

			while (tmp.NextSock != null && jumps < aIdx)
			{
				tmp = tmp.NextSock;
				jumps++;
			}

			if (jumps == aIdx)
				result = tmp;

			return ref result;
		}
		
		public virtual bool Connect() =>
			Connect(_host, _port);

		public virtual bool Connect(StringView aAddress, uint16 aPort)
		{
			_host = aAddress;
			_port = aPort;
			return false;
		}
		
		public virtual bool Listen() =>
			Listen(_port, _host);
		
		public abstract bool Listen(uint16 aPort, StringView aIntf = ADDR_ANY);
		
		public abstract int32 Get(char8* aData, int32 aSize, Socket aSocket = null);
		
		public abstract int32 GetMessage(String aOutMsg, Socket aSocket = null);
		
		public abstract int32 Send(char8* aData, int32 aSize, Socket aSocket = null);
		
		public abstract int32 SendMessage(StringView aMsg, Socket aSocket = null);
		
		public abstract bool IterNext();
		
		public abstract void IterReset();
	}
}
