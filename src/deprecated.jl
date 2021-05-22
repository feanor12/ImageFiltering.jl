if isdefined(OffsetArrays, :centered)
    # Compat for OffsetArrays v1.9
    # https://github.com/JuliaArrays/OffsetArrays.jl/pull/242  
    @deprecate centered OffsetArrays.centered
else
    """
    shiftedkernel = centered(kernel)

    Shift the origin-of-coordinates to the center of `kernel`.
    The center-element of `kernel` will be accessed by `shiftedkernel[0, 0, ...]`.

    This function makes it easy to supply kernels using regular Arrays,
    and provides compatibility with other languages that do not support
    arbitrary axes.

    See also: [`imfilter`](@ref).
    """
    function centered(A::AbstractArray)
        offsetted = first.(axes(A)) .- 1
        total_offsets = .-((size(A) .+ 1 ) .÷ 2)
        OffsetArray(A, total_offsets .- offsetted)
    end
end
