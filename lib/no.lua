function Chimes.no(center, m, key, no_no)
	if no_no then
		return center[m] or (G.GAME and G.GAME[m] and G.GAME[m][key]) or false
	end
	return Chimes.no(center, "no_" .. m, key, true)
end