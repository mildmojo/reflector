reflector (NOTE: spec below is not yet implemented)
=========

A simple pub/sub server for inter-app communication. Built with games and
second-screen applications in mind.

## Requirements
- Use traditional HTTP connections and verbs (no fancy websockets or
  long-polling tricks).
- Keep server interaction overhead minimal; applications should build messaging
  on top of the server.
- Aim to keep message delivery times under three seconds.

## Reasoning

### Traditional HTTP

There are lots of pub/sub systems and services built for low latency using
modern browser features. Faye, Slanger, Pusher, Pubnub, Socket.io, SignalR, and
others make heavy demands of their clients. By using traditional HTTP requests,
clients need only support a minimum feature set to make use of the server.

### Minimal communication overhead

Clients should use the server as a pipeline. Handshaking and communication
overhead should be minimal.

### Delivery times under three seconds

HTTP requests are short-lived so clients need to poll the server to check for
new messages. With that in mind, applications should be designed with high
latency in mind. I'd like the crossroads between server performance and user
expectations to be under three seconds.

## Model

Reflector has three basic units: rooms, channels, and messages.

### Rooms

A room is a messaging hub. The client who provisions a room will receive special
messages about other clients joining and leaving the room.

### Channels

Channels are transports for messages, connecting clients to rooms. Clients can
send messages on a channel or poll for newly-arrived messages. Each client gets
a unique channel upon connection to a room, which should allow for private
messages from one client to another or direct messages from the room owner to
a client.

### Messages

Messages are UTF-8 strings encapsulated in a JSON data structure.

```json
{ message: { body: 'move 5 north' } }
```
