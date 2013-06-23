(***********************************************************************)
(* zZp.mli - Field of integers mod p (for a settable prime p)          *)
(*                                                                     *)
(* Copyright (C) 2002, 2003, 2004, 2005, 2006, 2007, 2008, 2009, 2010, *)
(*               2011, 2012, 2013  Yaron Minsky and Contributors       *)
(*                                                                     *)
(* This file is part of SKS.  SKS is free software; you can            *)
(* redistribute it and/or modify it under the terms of the GNU General *)
(* Public License as published by the Free Software Foundation; either *)
(* version 2 of the License, or (at your option) any later version.    *)
(*                                                                     *)
(* This program is distributed in the hope that it will be useful, but *)
(* WITHOUT ANY WARRANTY; without even the implied warranty of          *)
(* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU   *)
(* General Public License for more details.                            *)
(*                                                                     *)
(* You should have received a copy of the GNU General Public License   *)
(* along with this program; if not, write to the Free Software         *)
(* Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 *)
(* USA or see <http://www.gnu.org/licenses/>.                          *)
(***********************************************************************)

open Core.Std
type t
include Comparable with type t := t

type tref
type mut_array
val order : tref
val nbits : int ref
val nbytes : int ref
val two : t
val zero : t
val one : t
val set_order : t -> unit
val num_bytes : unit -> int
val of_bytes : string -> t
val to_bytes : t -> string
val of_int : int -> t
val to_N : 'a -> 'a
val of_N : t -> t
val add : t -> t -> t
val sub : t -> t -> t
val mul : t -> t -> t
val mult : t -> t -> t
val imult : t -> int -> t
val add_fast : t -> t -> t
val mul_fast : t -> t -> t
val mult_fast : t -> t -> t
val canonicalize : t -> t
val square : t -> t
val square_fast : t -> t
val imul : t -> t -> t
val neg : t -> t
val inv : t -> t
val div : t -> t -> t
(* val sub_fast : t -> t -> t *)
val lt : t -> t -> bool
val gt : t -> t -> bool
val eq : t -> t -> bool
val neq : t -> t -> bool
val to_string : t -> string
val of_string : string -> t
val print : t -> unit
val points : int -> t array
val svalues : int -> mut_array
val mult_in : tref -> t -> t -> unit
(* val mult_fast_in : tref -> t -> t -> unit *)
val add_in : tref -> t -> t -> unit
(* val add_fast_in : tref -> t -> t -> unit *)
val sub_in : tref -> t -> t -> unit
(* val sub_fast_in : tref -> t -> t -> unit *)
val copy_in : tref -> t -> unit
val copy_out : tref -> t
val make_ref : t -> tref
val look : tref -> t
val canonicalize_in : tref -> unit
val add_el_array : points: t array -> t -> t array
val del_el_array : points: t array -> t -> t array
val mult_array : svalues:mut_array -> t array -> unit
val add_el : svalues:mut_array -> points:t array -> t -> unit
val del_el : svalues:mut_array -> points:t array -> t -> unit
val array_mult : t array -> t array -> t array
val mut_array_div : mut_array -> mut_array -> t array
val mut_array_copy : mut_array -> mut_array
val cmp : t -> t -> int
val length : mut_array -> int
val mut_array_to_array : mut_array -> t array
val mut_array_of_array : t array -> mut_array
val to_string_array : t -> string array
val rand : (unit -> int) -> t

val zset_of_list : t list -> Set.t
val canonical_of_number : Number.z -> t
val of_number : Number.z -> t
val to_number : t -> Number.z
module Infix : sig
  val ( +: ) : t -> t -> t
  val ( -: ) : t -> t -> t
  val ( *: ) : t -> t -> t
  val ( /: ) : t -> t -> t
  val ( =: ) : t -> t -> bool
  val ( <>: ) : t -> t -> bool
end
