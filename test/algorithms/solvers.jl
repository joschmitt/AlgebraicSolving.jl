@testset "Algorithms -> Solvers" begin
    R, (x1,x2,x3,x4) = PolynomialRing(QQ,["x1","x2","x3","x4"], ordering=:degrevlex)
    I = Ideal([x1 + 2*x2 + 2*x3 + 2*x4 - 1,
         x1^2 + 2*x2^2 + 2*x3^2 + 2*x4^2 - x1,
         2*x1*x2 + 2*x2*x3 + 2*x3*x4 - x2,
         x2^2 + 2*x1*x3 + 2*x2*x4 - x3])
    sols = Vector{fmpq}[
            [2673214459816888010217//4722366482869645213696, 1409093337151698926217//9444732965739290427392, 1206751508225034314151//4722366482869645213696, -1773444330549010351039//9444732965739290427392],
            [8311506369009768102275//18889465931478580854784, 11604140745194031729325//37778931862957161709568, 998877383835098408915//9444732965739290427392, -5021690718065612612481//37778931862957161709568],
            [1, 0, 0, 0],
            [451097390176582339670201//604462909807314587353088, 9032107101666684496743639//38685626227668133590597632, -7141673980382955904693279//38685626227668133590597632, 3017263506899703333802025//38685626227668133590597632],
            [7087075322218650694049//37778931862957161709568, 1480060550928923391483//18889465931478580854784, 2780329556045248126029//37778931862957161709568, 38421910449864642395061//151115727451828646838272],
            [196765270119568550571//590295810358705651712, 0, 1//2361183241434822606848, 787061080478274202283//2361183241434822606848]
                            ]
    rat_sols = Vector{fmpq}[[49, 0, 0, 0], [49//3, 0, 0, 1//3]]

    @test sols == real_solutions(I)
    @test rat_sols == rational_solutions(I)
    @test I.real_sols == real_solutions(I)
    
    C, x = PolynomialRing(QQ, "x")
    elim  = 128304*x^8 - 93312*x^7 + 15552*x^6 + 3144*x^5 - 1120*x^4 + 36*x^3 + 15*x^2 - x
    denom = 1026432*x^7 - 653184*x^6 + 93312*x^5 + 15720*x^4 - 4480*x^3 + 108*x^2 + 30*x - 1
    p1    = -3872448*x^7 + 2607552*x^6 - 408528*x^5 - 63088*x^4 + 20224*x^3 - 540*x^2 - 172*x + 7
    p2    = -303264*x^7 + 314928*x^6 - 113544*x^5 + 9840*x^4 + 3000*x^3 - 564*x^2 + 12*x
    p3    = -699840*x^7 + 449712*x^6 - 74808*x^5 - 1956*x^4 + 1308*x^3 - 174*x^2 + 18*x
    p1   *= -7
    p2   *= -7
    p3   *= -7

    param = rational_parametrization(I)

    @test param.vars == [:x1, :x2, :x3, :x4]
    @test param.lf_cfs == fmpz[]
    @test param.elim == elim
    @test param.denom == denom
    @test param.param[1] == p1
    @test param.param[2] == p2
    @test param.param[3] == p3
    @test I.rat_param.elim == elim
    @test I.rat_param.denom == denom
    @test I.rat_param.param[1] == p1
    @test I.rat_param.param[2] == p2
    @test I.rat_param.param[3] == p3

    I = Ideal([x1^2-x2, x1*x3-x4, x2*x4-12, x4^3-x3^2])
    real_solutions(I)
    @test I.rat_param.vars == Symbol[]
end
