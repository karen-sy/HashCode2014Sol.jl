var documenterSearchIndex = {"docs":
[{"location":"","page":"Home","title":"Home","text":"CurrentModule = HashCode2014Sol","category":"page"},{"location":"#HashCode2014Sol-Documentation","page":"Home","title":"HashCode2014Sol Documentation","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"Documentation for HashCode2014Sol.","category":"page"},{"location":"","page":"Home","title":"Home","text":"","category":"page"},{"location":"","page":"Home","title":"Home","text":"Modules = [HashCode2014Sol]","category":"page"},{"location":"#HashCode2014Sol.add_route!-Tuple{HashCode2014Sol.RouteGrid, HashCode2014Sol.Route}","page":"Home","title":"HashCode2014Sol.add_route!","text":"add_route!(route_grid, route)\n\nRegister a new Route to RouteGrid\n\n\n\n\n\n","category":"method"},{"location":"#HashCode2014Sol.change_duration-Tuple{HashCode2014.City, Any}","page":"Home","title":"HashCode2014Sol.change_duration","text":"change_duration(city, total_duration)\n\nCreate a new City with a different total_duration and everything else equal.\n\n\n\n\n\n","category":"method"},{"location":"#HashCode2014Sol.check_junction-Tuple{HashCode2014Sol.RouteGrid, Int64, Int64}","page":"Home","title":"HashCode2014Sol.check_junction","text":"check_junction(route_grid, street_idx_1, street_idx_2)\n\nCheck if two Streets of the given indices in the RouteGrid intersect at a Junction. If so, return (true, Junction); else, return (false, nothing)\n\n\n\n\n\n","category":"method"},{"location":"#HashCode2014Sol.check_route-Tuple{HashCode2014Sol.RouteGrid, Int64, Int64}","page":"Home","title":"HashCode2014Sol.check_route","text":"check_route(route_grid, junction_idx_start, junction_idx_end)\n\nCheck if there exists a Route from two Junctions of the given indices in a RouteGrid. The first index denotes the start junction, and the second index denotes the end junction. If so, return (true, Route). Else, return (false, nothing).\n\n\n\n\n\n","category":"method"},{"location":"#HashCode2014Sol.delete_route!-Tuple{HashCode2014Sol.RouteGrid, Int64, Int64}","page":"Home","title":"HashCode2014Sol.delete_route!","text":"delete_route!(route_grid, junc_idx_start, junc_idx_end)\n\nDelete an existing Route between two streets from RouteGrid. The first index denotes the start street, and the second index denotes the end street.\n\n\n\n\n\n","category":"method"},{"location":"#HashCode2014Sol.replace_route!-Tuple{HashCode2014Sol.RouteGrid, HashCode2014Sol.Route}","page":"Home","title":"HashCode2014Sol.replace_route!","text":"replace_route!(route_grid, new_route)\n\nReplace an existing Route between two junctions in RouteGrid with a new Route  \n\n\n\n\n\n","category":"method"},{"location":"#HashCode2014Sol.route-Tuple{Vector{HashCode2014.Street}, Int64, Int64}","page":"Home","title":"HashCode2014Sol.route","text":"route(streets, start_junc_idx, end_junc_idx)\n\nCreate a Route from the in-RouteGrid indices of its start and end junctions\n\n\n\n\n\n","category":"method"},{"location":"#HashCode2014Sol.routegrid-Tuple{HashCode2014.City}","page":"Home","title":"HashCode2014Sol.routegrid","text":"routegrid(city)\n\nCreate a RouteGrid from a specified City. \n\n\n\n\n\n","category":"method"},{"location":"#HashCode2014Sol.routegrid-Tuple{}","page":"Home","title":"HashCode2014Sol.routegrid","text":"routegrid()\n\nCreate a RouteGrid from the official challenge City. \n\n\n\n\n\n","category":"method"}]
}
