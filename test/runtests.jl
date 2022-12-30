using CBFs
using Test
using LinearAlgebra
using ForwardDiff

@testset "cbf_qp" begin

    h = 0.5
    Lfh = -1.0
    Lgh = [1 ;; 2.0]
    α = 1.0
    u0 = [0.0, -10.0]

    u_lib = cbf_qp(u0, h, Lfh, Lgh, α)

    u_analytic = 1.0 * [41/10, -9/5]

    @test u_lib ≈ u_analytic


    # now test with non-diagonal weight matrix
    P = Diagonal([5,2.])

    u_analytic_2 = 1.0 * [41/22, -15/22]

    u_lib_2 = cbf_qp(u0, h, Lfh, Lgh, α, P=P)

    @test u_lib ≈ u_analytic

    # now in a scenario that is not constrained
    h = 200.0

    u_lib_3 = cbf_qp(u0, h, Lfh, Lgh, α)

    u_analytic_3 = 1.0 * [0, -10]

    @test u_lib_3 ≈ u_analytic_3


end

@testset "cbf_qp_2" begin

    h = 0.5
    Lfh = -1.0
    Lgh = [1 ;; 2.0]
    α(r) = 3.0*r^2
    u0 = [0.0, -10.0]

    u_lib = cbf_qp(u0, h, Lfh, Lgh, α)


    u_analytic = 1.0 * [81/20, -19/10]


    @test u_lib ≈ u_analytic


end


@testset "double integrator" begin

  ## Define control-affine dynamics
  f(x) = [x[2], 0]              # should be a vector
  g(x) = reshape([0, 1.], 2, 1) # should be a matrix
  
  ## Define the barrier function
  h(x) = -x[2] + (2.0 - x[1])
  
  # construct Lfh, Lgh
  dhdx(x) = ForwardDiff.gradient(h, x)
  Lfh(x) = dhdx(x)' * f(x)
  Lgh(x) = dhdx(x)' * g(x)
  
  ## define the class-K function
  # α(r) = 1.0 * r^2  # define a function
  α = 1.0             # or simply define a linear class-K function
  
  
  # desired control input
  u0 = [1.0]                  # should be a vector 
  
  # state:
  x = [1.0, 0.8]
    
  # solve for a safe control input:
  u_cbf = cbf_qp(u0, h(x), Lfh(x), Lgh(x), α)

  @test u_cbf ≈ [-0.6]

end
