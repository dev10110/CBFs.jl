using CBFs
using Test
using LinearAlgebra

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
