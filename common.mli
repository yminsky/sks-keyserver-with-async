exception Transaction_aborted of string
exception Argument_error of string
exception Unit_test_failure of string

val enforced_filters : string list
val version_tuple : int * int * int
val version_suffix : string
val compatible_version_tuple : int * int * int
val version : string
val compatible_version_string : string
val period_regexp : Str.regexp
val parse_version_string : string -> int * int * int
val logfile : out_channel ref
val stored_logfile_name : string option ref
val plerror : int -> ('a, unit, string, unit) format4 -> 'a
val set_logfile : string -> unit
val reopen_logfile : unit -> unit
val perror : ('a, unit, string, unit) format4 -> 'a
val eplerror : int -> exn -> ('a, unit, string, unit) format4 -> 'a
val eperror : exn -> ('a, unit, string, unit) format4 -> 'a
val catch_break : bool ref
val set_catch_break : bool -> unit
val decomment : string -> string

type event = Add of string | Delete of string
type timestamp = float

val whitespace : Str.regexp
val make_addr_list : string -> int -> Unix.sockaddr list
val recon_port : int
val recon_address : string
val http_port : int
val http_address : string
val db_command_name : string
val recon_command_name : string
val db_command_addr : Unix.sockaddr
val recon_command_addr : Unix.sockaddr
val recon_addr_to_http_addr : Unix.sockaddr -> Unix.sockaddr
val get_client_recon_addr : unit -> Unix.sockaddr list
val match_client_recon_addr : Unix.sockaddr -> Unix.sockaddr
