exception Bad_key
exception Standalone_revocation_certificate
val filters : string list
val get_keypacket : KeyMerge.pkey -> Packet.t
val join_by_keypacket : KeyMerge.pkey list -> KeyMerge.pkey list list
val merge_pkeys : KeyMerge.pkey list -> KeyMerge.pkey
val compute_merge_replacements :
  Packet.t list list ->
  (Packet.t list list * Packet.t list) list
val canonicalize : Packet.t list -> Packet.t list
val good_key : Packet.t -> bool
val good_signature : Packet.t -> bool
val drop_bad_sigs : Packet.t list -> Packet.t list
val sig_filter_sigpair :
  'a * Packet.t list -> ('a * Packet.t list) option
val presentation_filter : Packet.t list -> Packet.t list option
