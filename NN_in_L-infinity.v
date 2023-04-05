Require Import Notations Logic Datatypes.
Local Open Scope nat_scope.


Fixpoint add n m :=
  match n with
  | 0 => m
  | S p => S (p + m)
  end

where "n + m" := (add n m) : nat_scope.

Fixpoint sub n m :=
  match n, m with
  | S k, S l => k - l
  | _, _ => n
  end

where "n - m" := (sub n m) : nat_scope.

Fixpoint max n m :=
  match n, m with
    | 0, _ => m
    | S n', 0 => n
    | S n', S m' => S (max n' m')
  end.

Fixpoint mul n m :=
  match n with
  | 0 => 0
  | S p => m + p * m
  end

where "n * m" := (mul n m) : nat_scope.
Variable N11 N12 N13 N21 N22 N23 N24 N31 N32 N33 : nat.

Variable W111 W112 W113 W114 W121 W122 W123 W124 W131 W132 W133 W134 W211 W212 W213 W221 W222 W223 W231 W232 W233 W241 W242 W243: nat.
(*每個neuron的bias*)
Variable b11 b12 b13 b21 b22 b23 b24: nat.
(*在下一層關係式中會用到的max(neuron-weight)的bias*)
Variable B21 B22 B23 B24 B31 B32 B33: nat.
Variable ϵ λ: nat.
Variable X1 X2 X3 : nat.
(*b和B間的關係*)
Axiom B21_b11: max(sub N11 W111)(max(sub N12 W121)(sub N13 W131)) = (sub N11 W111) -> B21 = b11.
Axiom B21_b12: max(sub N11 W111)(max(sub N12 W121)(sub N13 W131)) = (sub N12 W121) -> B21 = b12.
Axiom B21_b13: max(sub N11 W111)(max(sub N12 W121)(sub N13 W131)) = (sub N13 W131) -> B21 = b13.

Axiom B22_b11: max(sub N11 W112)(max(sub N12 W122)(sub N13 W132)) = (sub N11 W111) -> B22 = b11.
Axiom B22_b12: max(sub N11 W112)(max(sub N12 W122)(sub N13 W132)) = (sub N12 W122) -> B22 = b12.
Axiom B22_b13: max(sub N11 W112)(max(sub N12 W122)(sub N13 W132)) = (sub N13 W132) -> B22 = b13.

Axiom B23_b11: max(sub N11 W113)(max(sub N12 W123)(sub N13 W133)) = (sub N11 W113) -> B23 = b11.
Axiom B23_b12: max(sub N11 W113)(max(sub N12 W123)(sub N13 W133)) = (sub N12 W123) -> B23 = b12.
Axiom B23_b13: max(sub N11 W113)(max(sub N12 W123)(sub N13 W133)) = (sub N13 W133) -> B23 = b13.

Axiom B24_b11: max(sub N11 W114)(max(sub N12 W124)(sub N13 W134)) = (sub N11 W114) -> B24 = b11.
Axiom B24_b12: max(sub N11 W114)(max(sub N12 W124)(sub N13 W134)) = (sub N12 W124) -> B24 = b12.
Axiom B24_b13: max(sub N11 W114)(max(sub N12 W124)(sub N13 W134)) = (sub N13 W134) -> B24 = b13.

Axiom B31_b21: max (sub N21 W211)(max(sub N22 W221)(max(sub N23 W231)(sub N24 W241))) = (sub N21 W211) -> B31 = b21.
Axiom B31_b22: max (sub N21 W211)(max(sub N22 W221)(max(sub N23 W231)(sub N24 W241))) = (sub N22 W221) -> B31 = b22.
Axiom B31_b23: max (sub N21 W211)(max(sub N22 W221)(max(sub N23 W231)(sub N24 W241))) = (sub N23 W231) -> B31 = b23.
Axiom B31_b24: max (sub N21 W211)(max(sub N22 W221)(max(sub N23 W231)(sub N24 W241))) = (sub N24 W241) -> B31 = b24.

Axiom B32_b21: max (sub N21 W212)(max(sub N22 W222)(max(sub N23 W232)(sub N24 W242))) = (sub N21 W212) -> B32 = b21.
Axiom B32_b22: max (sub N21 W212)(max(sub N22 W222)(max(sub N23 W232)(sub N24 W242))) = (sub N22 W222) -> B32 = b22.
Axiom B32_b23: max (sub N21 W212)(max(sub N22 W222)(max(sub N23 W232)(sub N24 W242))) = (sub N23 W232) -> B32 = b23.
Axiom B32_b24: max (sub N21 W212)(max(sub N22 W222)(max(sub N23 W232)(sub N24 W242))) = (sub N24 W242) -> B32 = b24.

Axiom B33_b21: max (sub N21 W213)(max(sub N22 W223)(max(sub N23 W233)(sub N24 W243))) = (sub N21 W213) -> B33 = b21.
Axiom B33_b22: max (sub N21 W213)(max(sub N22 W223)(max(sub N23 W233)(sub N24 W243))) = (sub N22 W223) -> B33 = b22.
Axiom B33_b23: max (sub N21 W213)(max(sub N22 W223)(max(sub N23 W233)(sub N24 W243))) = (sub N23 W233) -> B33 = b23.
Axiom B33_b24: max (sub N21 W213)(max(sub N22 W223)(max(sub N23 W233)(sub N24 W243))) = (sub N24 W243) -> B33 = b24.

(*normal neural network*)
Axiom _N11: N11 = X1 + b11.
Axiom _N12: N12 = X2 + b12.
Axiom _N13: N13 = X3 + b13.
Axiom _N21: N21 = max(sub N11 W111)(max(sub N12 W121)(sub N13 W131))-B21.
Axiom _N22: N22 = max(sub N11 W112)(max(sub N12 W122)(sub N13 W132))-B22.
Axiom _N23: N23 = max(sub N11 W113)(max(sub N12 W123)(sub N13 W133))-B23.
Axiom _N24: N24 = max(sub N11 W114)(max(sub N12 W124)(sub N13 W134))-B24.
Axiom _N31: N31 = max (sub N21 W211)(max(sub N22 W221)(max(sub N23 W231)(sub N24 W241))) - B31.
Axiom _N32: N32 = max (sub N21 W212)(max(sub N22 W222)(max(sub N23 W232)(sub N24 W242))) - B32.
Axiom _N33: N33 = max (sub N21 W213)(max(sub N22 W223)(max(sub N23 W233)(sub N24 W243))) - B33.

(*擾動後的參數*)
Variable N11' N12' N13' N21' N22' N23' N24' N31' N32' N33' : nat.
Variable B21' B22' B23' B24' B31' B32' B33': nat.

(*b和B'間的關係*)
Axiom B21'_b11: max(sub N11' W111)(max(sub N12' W121)(sub N13' W131)) = (sub N11' W111) -> B21' = b11.
Axiom B21'_b12: max(sub N11' W111)(max(sub N12' W121)(sub N13' W131)) = (sub N12' W121) -> B21' = b12.
Axiom B21'_b13: max(sub N11' W111)(max(sub N12' W121)(sub N13' W131)) = (sub N13' W131) -> B21' = b13.

Axiom B22'_b11: max(sub N11' W112)(max(sub N12' W122)(sub N13' W132)) = (sub N11' W111) -> B22' = b11.
Axiom B22'_b12: max(sub N11' W112)(max(sub N12' W122)(sub N13' W132)) = (sub N12' W122) -> B22' = b12.
Axiom B22'_b13: max(sub N11' W112)(max(sub N12' W122)(sub N13' W132)) = (sub N13' W132) -> B22' = b13.

Axiom B23'_b11: max(sub N11' W113)(max(sub N12' W123)(sub N13' W133)) = (sub N11' W113) -> B23' = b11.
Axiom B23'_b12: max(sub N11' W113)(max(sub N12' W123)(sub N13' W133)) = (sub N12' W123) -> B23' = b12.
Axiom B23'_b13: max(sub N11' W113)(max(sub N12' W123)(sub N13' W133)) = (sub N13' W133) -> B23' = b13.

Axiom B24'_b11: max(sub N11' W114)(max(sub N12' W124)(sub N13' W134)) = (sub N11' W114) -> B24' = b11.
Axiom B24'_b12: max(sub N11' W114)(max(sub N12' W124)(sub N13' W134)) = (sub N12' W124) -> B24' = b12.
Axiom B24'_b13: max(sub N11' W114)(max(sub N12' W124)(sub N13' W134)) = (sub N13' W134) -> B24' = b13.

Axiom B31'_b21: max (sub N21' W211)(max(sub N22' W221)(max(sub N23' W231)(sub N24' W241))) = (sub N21' W211) -> B31' = b21.
Axiom B31'_b22: max (sub N21' W211)(max(sub N22' W221)(max(sub N23' W231)(sub N24' W241))) = (sub N22' W221) -> B31' = b22.
Axiom B31'_b23: max (sub N21' W211)(max(sub N22' W221)(max(sub N23' W231)(sub N24' W241))) = (sub N23' W231) -> B31' = b23.
Axiom B31'_b24: max (sub N21' W211)(max(sub N22' W221)(max(sub N23' W231)(sub N24' W241))) = (sub N24' W241) -> B31' = b24.

Axiom B32'_b21: max (sub N21' W212)(max(sub N22' W222)(max(sub N23' W232)(sub N24' W242))) = (sub N21' W212) -> B32' = b21.
Axiom B32'_b22: max (sub N21' W212)(max(sub N22' W222)(max(sub N23' W232)(sub N24' W242))) = (sub N22' W222) -> B32' = b22.
Axiom B32'_b23: max (sub N21' W212)(max(sub N22' W222)(max(sub N23' W232)(sub N24' W242))) = (sub N23' W232) -> B32' = b23.
Axiom B32'_b24: max (sub N21' W212)(max(sub N22' W222)(max(sub N23' W232)(sub N24' W242))) = (sub N24' W242) -> B32' = b24.

Axiom B33'_b21: max (sub N21' W213)(max(sub N22' W223)(max(sub N23' W233)(sub N24' W243))) = (sub N21' W213) -> B33' = b21.
Axiom B33'_b22: max (sub N21' W213)(max(sub N22' W223)(max(sub N23' W233)(sub N24' W243))) = (sub N22' W223) -> B33' = b22.
Axiom B33'_b23: max (sub N21' W213)(max(sub N22' W223)(max(sub N23' W233)(sub N24' W243))) = (sub N23' W233) -> B33' = b23.
Axiom B33'_b24: max (sub N21' W213)(max(sub N22' W223)(max(sub N23' W233)(sub N24' W243))) = (sub N24' W243) -> B33' = b24.

(*neural network after perturbation*)
Axiom _N11': N11' = X1 + ϵ + b11.
Axiom _N12': N12' = X2 + ϵ + b12.
Axiom _N13': N13' = X3 + ϵ + b13.
Axiom _N21': N21' = max(sub N11' W111)(max(sub N12' W121)(sub N13' W131)) - B21'.
Axiom _N22': N22' = max(sub N11' W112)(max(sub N12' W122)(sub N13' W132)) - B22'.
Axiom _N23': N23' = max(sub N11' W113)(max(sub N12' W123)(sub N13' W133)) - B23'.
Axiom _N24': N24' = max(sub N11' W114)(max(sub N12' W124)(sub N13' W134)) - B24'.
Axiom _N31': N31' = max (sub N21' W211)(max(sub N22' W221)(max(sub N23' W231)(sub N24' W241))) - B31'.
Axiom _N32': N32' = max (sub N21' W212)(max(sub N22' W222)(max(sub N23' W232)(sub N24' W242))) - B32'.
Axiom _N33': N33' = max (sub N21' W213)(max(sub N22' W223)(max(sub N23' W233)(sub N24' W243))) - B33'.

(*lipsiz等式中max(N3i-N3i')則Xo,Xo'= N1i,N1i'*)
Variable Xo Xo': nat.
Axiom Xo_N11 : max(N31-N31') (max(N32-N32')(N33-N33')) = (N31-N31') -> Xo = N11 -> Xo' = N11'.
Axiom Xo_N12 : max(N31-N31') (max(N32-N32')(N33-N33')) = (N32-N32') -> Xo = N12 -> Xo' = N12'.
Axiom Xo_N13 : max(N31-N31') (max(N32-N32')(N33-N33')) = (N33-N33') -> Xo = N13 -> Xo' = N13'.
Lemma a: forall N31 N32 N33 N31' N32' N33', max(N31-N31')(max(N32-N32')(N33-N33'))<= mul λ (Xo - Xo').
