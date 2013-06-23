exception Bug of string
exception LayoutMismatch
val riter : f:(int -> 'a) -> int -> int -> unit
val rfind : f:(int -> bool) -> int -> int -> int
module MatrixSlow :
  sig
    type t = { columns : int; rows : int; array : ZZp.t array; }
    val columns : t -> int
    val rows : t -> int
    val dims : t -> int * int
    val copy : t -> t
    val make : columns:int -> rows:int -> ZZp.t -> t
    val init : columns:int -> rows:int -> f:(int -> int -> ZZp.t) -> t
    val get : t -> int -> int -> ZZp.t
    val set : t -> int -> int -> ZZp.t -> unit
    val scmult_ip : t -> ZZp.t -> unit
    val scmult : t -> ZZp.t -> t
    val scmult_row : t -> int -> ZZp.t -> unit
    val swap_rows : t -> int -> int -> unit
    val add_ip : t -> t -> unit
    val add : t -> t -> t
    val idot_rec :
      t -> t -> i:int -> pos1:int -> pos2:int -> ZZp.t -> ZZp.t
    val idot : t -> t -> int -> int -> ZZp.t
    val mult : t -> t -> t
    val transpose : t -> t
    val rowadd : t -> src:int -> dst:int -> scmult:ZZp.t -> unit
    val rowsub : t -> src:int -> dst:int -> scmult:ZZp.t -> unit
    val print : t -> unit
  end
module Matrix :
  sig
    type t = { columns : int; rows : int; array : ZZp.tref array; }
    val columns : t -> int
    val rows : t -> int
    val dims : t -> int * int
    val copy : t -> t
    val init : columns:int -> rows:int -> f:(int -> int -> ZZp.t) -> t
    val make : columns:int -> rows:int -> ZZp.t -> t
    val lget : t -> int -> int -> ZZp.t
    val rget : t -> int -> int -> ZZp.tref
    val get : t -> int -> int -> ZZp.t
    val set : t -> int -> int -> ZZp.t -> unit
    val scmult_row : ?scol:int -> t -> int -> ZZp.t -> unit
    val swap_rows : t -> int -> int -> unit
    val transpose : t -> t
    val rowsub :
      ?scol:int -> t -> src:int -> dst:int -> scmult:ZZp.t -> unit
    val print : t -> unit
  end
val process_row : Matrix.t -> int -> unit
val process_row_forward : Matrix.t -> int -> unit
val backsubstitute : Matrix.t -> int -> unit
val greduce : Matrix.t -> unit
val reduce : Matrix.t -> unit
