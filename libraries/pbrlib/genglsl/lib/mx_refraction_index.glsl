// Convert a real-valued index of refraction to normal-incidence reflectivity.
float mx_ior_to_f0(float ior)
{
    return mx_square((ior - 1.0) / (ior + 1.0));
}

// "Artist Friendly Metallic Fresnel", Ole Gulbrandsen, 2014
// http://jcgt.org/published/0003/04/03/paper.pdf

void mx_complex_to_artistic_ior(vec3 ior, vec3 extinction, out vec3 reflectivity, out vec3 edge_color)
{
    vec3 nm1 = ior - 1.0;
    vec3 np1 = ior + 1.0;
    vec3 k2  = extinction * extinction;
    vec3 r = (nm1*nm1 + k2) / (np1*np1 + k2);
    reflectivity = r;

    vec3 r_sqrt = sqrt(r);
    vec3 n_min = (1.0 - r) / (1.0 + r);
    vec3 n_max = (1.0 + r_sqrt) / (1.0 - r_sqrt);
    edge_color = (n_max - ior) / (n_max - n_min);
}

void mx_artistic_to_complex_ior(vec3 reflectivity, vec3 edge_color, out vec3 ior, out vec3 extinction)
{
    vec3 r = clamp(reflectivity, 0.0, 0.99);
    vec3 r_sqrt = sqrt(r);
    vec3 n_min = (1.0 - r) / (1.0 + r);
    vec3 n_max = (1.0 + r_sqrt) / (1.0 - r_sqrt);
    ior = mix(n_max, n_min, edge_color);

    vec3 np1 = ior + 1.0;
    vec3 nm1 = ior - 1.0;
    vec3 k2 = (np1*np1 * r - nm1*nm1) / (1.0 - r);
    k2 = max(k2, 0.0);
    extinction = sqrt(k2);
}
