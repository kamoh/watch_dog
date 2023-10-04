## grid stuff

# Define the grid size
rows=3  # Number of rows (avenues)
cols=3  # Number of columns (streets)


# Create directories for intersections (grid points)
for ((i = 1; i <= rows; i++)); do
    for ((j = 1; j <= cols; j++)); do
        intersection="intersection_${i}_${j}"
        mkdir -p "$intersection"
    done
done

# Create symbolic links to connect intersections
for ((i = 1; i <= rows; i++)); do
    for ((j = 1; j <= cols; j++)); do
        intersection="intersection_${i}_${j}"

        if [ $i -lt $rows ]; then
            south_intersection="intersection_$((i + 1))_${j}"
            ln -s "../$south_intersection" "$intersection/south"
            ln -s "../$intersection" "$south_intersection/north"
        fi

        if [ $i -gt 1 ]; then
            north_intersection="intersection_$((i - 1))_${j}"
            ln -s "../$north_intersection" "$intersection/north"
            ln -s "../$intersection" "$north_intersection/south"
        fi

        if [ $j -lt $cols ]; then
            east_intersection="intersection_${i}_$((j + 1))"
            ln -s "../$east_intersection" "$intersection/east"
            ln -s "../$intersection" "$east_intersection/west"
        fi

        if [ $j -gt 1 ]; then
            west_intersection="intersection_${i}_$((j - 1))"
            ln -s "../$west_intersection" "$intersection/west"
            ln -s "../$intersection" "$west_intersection/east"
        fi
    done
done

##