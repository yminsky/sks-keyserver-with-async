open Core.Std

val det_rng : Random.State.t
val stringset_to_string : String.Set.t -> string
val digest_stringset : String.Set.t -> Digest.t
val print_lengths : string list -> unit
val fill_random_string :
  (unit -> int) -> string -> pos:int -> len:int -> unit
val random_string : (unit -> int) -> int -> string
val conv_chans :
  in_channel * out_channel ->
  MeteredChannel.metered_in_channel * MeteredChannel.metered_out_channel
val add_random : (unit -> int) -> int -> String.Set.t -> String.Set.t
val add_n_random :
  (unit -> int) -> int -> n:int -> String.Set.t -> String.Set.t
val det_string_set : bytes:int -> size:int -> String.Set.t
val rand_string_set : bytes:int -> size:int -> String.Set.t
val localize_string_set :
  bytes:int -> diff:int -> String.Set.t -> String.Set.t
val add_sarray : data:('a,'b) Set.t -> 'a array -> ('a,'b) Set.t
val pad : string -> int -> string
val padset : String.Set.t -> int -> String.Set.t
val truncate : string -> int -> string
val truncset : String.Set.t -> int -> String.Set.t
val order_string : string
val print_ZZp_list : ZZp.zz list -> unit
val print_ZZp_set : ZZp.Set.t -> unit
