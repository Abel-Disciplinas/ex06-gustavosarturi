function simpsonrep(f, a, b; m = 101)
    m % 2 == 0 && (m += 1) #If
    h = (b - a) / (m - 1)
    v = zeros(m) #Cria vetor coluna de m posições;
    for i = 1:m
        v[i] = a + h * (i-1)
    end
    Σ1, ⁠⁠Σ2 = (0, 0)
    for i = 2: 2: m-1
        Σ1 += f(v[i])
        Σ2 += f(v[i + 1])
    end
    Σ2 -= f(v[m])
    return (h / 3) * (f(v[1]) + 4 * Σ1 + 2 * Σ2 + f(v[m]))
end

function simpsoneps(f, a, b, ϵ; M = 1.0) #calculo do novo ϵ
    h = ((180 * ϵ) / ((b - a) * M))^(0.25)
    m = ceil(Int, (b - a)/h + 1) #ceil arredonda para +, Ex.: ceil(π) = 4.0
    return simpsonrep(f, a, b, m)
end

function simpson(f, a, b)
    μ = (b - a) / 6
    return μ * (f(a) + 4 * f((a + b) * 0.5) + f(b))
end

function simpson_adaptivo(f, a, b, ϵ)
    ∫ = simpson(f, a, b)
    return simpson_adaptivo_recursivo(f, a, b, ϵ, ∫)
end

function simpson_adaptivo_recursivo(f, a, b, ϵ, I)
    m = (a + b) * 0.5
    R = simpson(f, a, b)
    L = simpson(f, a, c)
    M = abs(I - L - R)
    if M < 15ϵ
        return L + R
    end
    SL = simpson_adaptivo_recursivo(f, a, c, ϵ * 0.5, L) #Simp. Rec. Esquerda
    SR = simpson_adaptivo_recursivo(f, c, b, ϵ * 0.5, R) #Simp. Rec. Direita
end
