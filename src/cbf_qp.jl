"""
    u = cbf_qp(u0, h, Lfh, Lgh, α; P=I)

Returns the CBF QP control input, i.e. the result of

```math
\\begin{aligned}
u = \\min_{u \\in \\mathbb{R}^m} \\quad & \\quad \\frac{1}{2} (u - u_0)^T P (u - u_0)\\\\
\\quad \\quad s.t. \\quad & \\quad L_fh + L_gh u \\leq - \\alpha(h)
\\end{aligned}
```

If `α<:Real`, we assume `α(r) = α r`
"""
function cbf_qp(u0, h, Lfh, Lgh, α::R; P=I) where {R <: Real}

  s = Lfh + first(Lgh * u0) + α * h

  if s >= 0.0
    return u0
  else

    v = P \ Lgh'

    return u0 - (s / (first(Lgh * v))) * v
  end
end



function cbf_qp(u0, h, Lfh, Lgh, α; P=I)

  s = Lfh + first(Lgh * u0) + α(h)

  if s >= 0.0
    return u0
  else

    v = P \ Lgh'

    return u0 - (s / (first(Lgh * v))) * v
  end
end

