function k = calc_k(oma, omf, lambda, rhoP, rhoV)
    k = 1/rhoV * (oma^2 * (rhoP - rhoV) / (omf^2 + lambda^2)-rhoP);
end