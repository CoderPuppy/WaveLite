
 -- NOTE: need to work on overlap

local function compare( a, b )
	return a[1] > b[1] or a[1] == b[1] and a[2] > b[2]
end

local function newCursorSystem()

	local s = {}

	s.cursors = {}

	function s:setCursor( cursor, t, keepSelection )
		if t then
			self.cursors[cursor] = { cursor = t, selection = keepSelection and (self.cursors[cursor].selection or self.cursors[cursor].cursor) or false }
		else
			self.cursors = { { cursor = cursor, selection = false } }
		end
	end

	function s:setCursorSelection( cursor, t )
		self.cursors[cursor].selection = t or false
	end

	function s:addCursor( t )
		self.cursors[#self.cursors + 1] = { cursor = t, selection = false }
	end

	function s:getCursor( cursor )
		return self.cursors[cursor].cursor
	end

	function s:getCursorSelection( cursor )
		return self.cursors[cursor].selection
	end

	function s:order( a, b ) -- returns min, max of the two cursors
		if not b then
			return a
		elseif compare( a, b ) then
			return b, a
		else
			return a, b
		end
	end

	function s:getCursorCount()
		return #self.cursors
	end

	function s:getOrderedList()
		local t = {}

		for i = 1, #self.cursors do
			t[i] = { i, self:order( self:getCursor( i ), self:getCursorSelection( i ) ) }
		end

		table.sort( t, function( a, b ) return compare( a[2], b[2] ) end )

		return t
	end

	function s:getLocationUp( cursor, body )
		local l, c = self.cursors[cursor].cursor[1], self.cursors[cursor].cursor[2]
		return l > 1 and { l - 1, c } or { 1, 1 }
	end

	function s:getLocationDown( cursor, body )
		local l, c = self.cursors[cursor].cursor[1], self.cursors[cursor].cursor[2]
		return l < #body.lines and { l + 1, c } or { #body.lines, #body.lines[#body.lines] + 1 }
	end

	function s:getLocationLeft( cursor, body )
		local l = self.cursors[cursor].cursor[1]
		local c = math.min( self.cursors[cursor].cursor[2], #body.lines[l] + 1 )
		return c > 1 and { l, c - 1 } or l > 1 and { l - 1, #body.lines[l - 1] + 1 } or { 1, 1 }
	end

	function s:getLocationRight( cursor, body )
		local l, c = self.cursors[cursor].cursor[1], self.cursors[cursor].cursor[2]
		return c <= #body.lines[l] and { l, c + 1 } or l < #body.lines and { l + 1, 1 } or { #body.lines, #body.lines[#body.lines] + 1 }
	end

	function s:getDrawableCursor( cursor, body )
		local c = self.cursors[cursor]
		return          {c.cursor[1],    math.min( c.cursor[2],    #body.lines[   c.cursor[1]] + 1 )},
		c.selection and {c.selection[1], math.min( c.selection[2], #body.lines[c.selection[1]] + 1 )}
	end

	return s

end

return newCursorSystem
