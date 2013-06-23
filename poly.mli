val rfind : f:(int -> bool) -> int -> int -> int
type t = { a : ZZp.t array; degree : int; }
val compute_degree : ZZp.t array -> int
val init : int -> f:(int -> ZZp.t) -> t
val make : int -> ZZp.t -> t
val zero : t
val one : t
val degree : t -> int
val length : t -> int
val copy : t -> t
val to_string : t -> string
val splitter : Str.regexp
val parse_digit : string -> int * ZZp.t
val of_string : string -> t
val print : t -> unit
exception NotEqual
val eq : t -> t -> bool
val of_array : ZZp.t array -> t
val term : int -> ZZp.t -> t
val set_length : int -> t -> t
val to_array : t -> ZZp.t array
val is_monic : t -> bool
val eval : t -> ZZp.t -> ZZp.t
val mult : t -> t -> t
val scmult : t -> ZZp.t -> t
val add : t -> t -> t
val neg : t -> t
val sub : t -> t -> t
val divmod : t -> t -> t * t
val modulo : t -> t -> t
val div : t -> t -> t
val const_coeff : t -> ZZp.t
val nth_coeff : t -> int -> ZZp.t
val const : ZZp.t -> t
val gcd_rec : t -> t -> t
val gcd : t -> t -> t
