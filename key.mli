exception Bug of string
val pos_next_rec :
  ('a * Packet.t) SStream.sstream ->
  Packet.t list -> Packet.t list option
val pos_next :
  ('a * Packet.t) SStream.sstream -> ('a * Packet.t list) option
val pos_get : ('a * Packet.t) SStream.sstream -> 'a * Packet.t list
val pos_next_of_channel :
  < inchan : in_channel; read_byte : int; read_string : int -> string; .. > ->
  unit -> (int64 * Packet.t list) option
val pos_get_of_channel :
  < inchan : in_channel; read_byte : int; read_string : int -> string; .. > ->
  unit -> int64 * Packet.t list
val next_rec :
  Packet.t SStream.sstream ->
  Packet.t list -> Packet.t list option
val next : Packet.t SStream.sstream -> Packet.t list option
val get : Packet.t SStream.sstream -> Packet.t list
val next_of_channel :
  < read_byte : int; read_string : int -> string; .. > ->
  unit -> Packet.t list option
val get_of_channel :
  < read_byte : int; read_string : int -> string; .. > ->
  unit -> Packet.t list
val get_ids : Packet.t list -> string list
val write :
  Packet.t list ->
  < write_byte : int -> 'a; write_int : int -> 'b;
    write_string : string -> unit; .. > ->
  unit
val to_string : Packet.t list -> string
val of_string : string -> Packet.t list
val of_string_multiple : string -> Packet.t list list
val to_string_multiple : Packet.t list list -> string
val to_words : Packet.t list -> string list
