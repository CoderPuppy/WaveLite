
local plugin = require "src.plugin"
local event = require "src.event"
local editor = require "src.editor"
local res = require "src.resource"

res.register( "style", "light", "resources.styles.light" )
res.register( "style", "dark", "resources.styles.dark" )

res.register( "language", "plain text", "resources.languages.plain text" )
res.register( "language", "lua", "resources.languages.lua" )
res.register( "language", "flux", "resources.languages.flux" )

--[[
event.bind( "editor:key:left", function()
	plugin.api.cursor_left( false, false, false )
	plugin.api.cursor_onscreen()
end )
event.bind( "editor:key:right", function()
	plugin.api.cursor_right( false, false, false )
	plugin.api.cursor_onscreen()
end )
event.bind( "editor:key:shift-left", function()
	plugin.api.cursor_left( true, false, false )
	plugin.api.cursor_onscreen()
end )
event.bind( "editor:key:shift-right", function()
	plugin.api.cursor_right( true, false, false )
	plugin.api.cursor_onscreen()
end )
event.bind( "editor:key:alt-left", function()
	plugin.api.cursor_left( false, true, false )
	plugin.api.cursor_onscreen()
end )
event.bind( "editor:key:alt-right", function()
	plugin.api.cursor_right( false, true, false )
	plugin.api.cursor_onscreen()
end )
event.bind( "editor:key:ctrl-left", function()
	plugin.api.cursor_left( false, false, true )
	plugin.api.cursor_onscreen()
end )
event.bind( "editor:key:ctrl-right", function()
	plugin.api.cursor_right( false, false, true )
	plugin.api.cursor_onscreen()
end )
event.bind( "editor:key:ctrl-shift-left", function()
	plugin.api.cursor_left( true, false, true )
	plugin.api.cursor_onscreen()
end )
event.bind( "editor:key:ctrl-shift-right", function()
	plugin.api.cursor_right( true, false, true )
	plugin.api.cursor_onscreen()
end )

event.bind( "editor:key:up", function()
	plugin.api.cursor_up( false, false, false )
	plugin.api.cursor_onscreen()
end )
event.bind( "editor:key:down", function()
	plugin.api.cursor_down( false, false, false )
	plugin.api.cursor_onscreen()
end )
event.bind( "editor:key:alt-up", function()
	plugin.api.cursor_up( false, true, false )
	plugin.api.cursor_onscreen()
end )
event.bind( "editor:key:alt-down", function()
	plugin.api.cursor_down( false, true, false )
	plugin.api.cursor_onscreen()
end )
event.bind( "editor:key:shift-up", function()
	plugin.api.cursor_up( true, false, false )
	plugin.api.cursor_onscreen()
end )
event.bind( "editor:key:shift-down", function()
	plugin.api.cursor_down( true, false, false )
	plugin.api.cursor_onscreen()
end )

event.bind( "editor:key:return", function()
	plugin.api.write( "\n", true )
	editor.resetCursorBlink()
	plugin.api.cursor_onscreen()
end )
event.bind( "editor:key:tab", function()
	plugin.api.write( "\t", true )
	editor.resetCursorBlink()
	plugin.api.cursor_onscreen()
end )
event.bind( "editor:key:backspace", function()
	plugin.api.backspace( "\n", true )
	editor.resetCursorBlink()
	plugin.api.cursor_onscreen()
end )
event.bind( "editor:key:delete", function()
	plugin.api.delete( "\t", true )
	editor.resetCursorBlink()
	plugin.api.cursor_onscreen()
end )

event.bind( "editor:key:kp1", function()
	plugin.api.cursor_end()
	plugin.api.cursor_onscreen()
end )
event.bind( "editor:key:kp7", function()
	plugin.api.cursor_home()
	plugin.api.cursor_onscreen()
end )

event.bind( "editor:key:ctrl-v", function()
	plugin.api.write( love.system.getClipboardText(), false )
	plugin.api.cursor_onscreen()
	editor.resetCursorBlink()
end )

event.bind( "editor:key:ctrl-c", function()
	love.system.setClipboardText( plugin.api.text() )
end )

event.bind( "editor:key:ctrl-x", function()
	love.system.setClipboardText( plugin.api.text() )
	plugin.api.write( "", false )
	editor.resetCursorBlink()
	plugin.api.cursor_onscreen()
end )

event.bind( "editor:key:ctrl-a", function()
	local lines = plugin.api.count_lines()
	local text = plugin.api.count_text( lines )

	plugin.api.set_cursor( lines, text + 1, 1, 1 )
end )
]]

local function wrapf_cursor( f, ... )
	local t = { ... }
	return function( v )
		f( v, unpack( t ) )
	end
end

event.bind( "editor:key:ctrl-s", function( editor )
	editor.map_cursors( editor.select_line )
end )

event.bind( "editor:key:kp7", function( editor )
	editor.map_cursors( editor.cursor_home, nil, { select = false, create = false, full = false } )
end )

event.bind( "editor:key:kp1", function( editor )
	editor.map_cursors( editor.cursor_end, nil, { select = false, create = false, full = false } )
end )

event.bind( "editor:key:shift-kp7", function( editor )
	editor.map_cursors( editor.cursor_home, nil, { select = true, create = false, full = false } )
end )

event.bind( "editor:key:shift-kp1", function( editor )
	editor.map_cursors( editor.cursor_end, nil, { select = true, create = false, full = false } )
end )

event.bind( "editor:key:ctrl-kp7", function( editor )
	editor.map_cursors( editor.cursor_home, nil, { select = false, create = false, full = true } )
end )

event.bind( "editor:key:ctrl-kp1", function( editor )
	editor.map_cursors( editor.cursor_end, nil, { select = false, create = false, full = true } )
end )

event.bind( "editor:key:up", function( editor )
	editor.map_cursors( editor.cursor_up, nil, { select = false, create = false } )
end )

event.bind( "editor:key:down", function( editor )
	editor.map_cursors( editor.cursor_down, nil, { select = false, create = false } )
end )

event.bind( "editor:key:alt-up", function( editor )
	editor.map_cursors( editor.cursor_up, nil, { select = false, create = true } )
end )

event.bind( "editor:key:alt-down", function( editor )
	editor.map_cursors( editor.cursor_down, nil, { select = false, create = true } )
end )

event.bind( "editor:key:shift-up", function( editor )
	editor.map_cursors( editor.cursor_up, nil, { select = true, create = false } )
end )

event.bind( "editor:key:shift-down", function( editor )
	editor.map_cursors( editor.cursor_down, nil, { select = true, create = false } )
end )

event.bind( "editor:key:left", function( editor )
	editor.map_cursors( editor.cursor_left, nil, { select = false, by_word = false, create = false } )
end )

event.bind( "editor:key:right", function( editor )
	editor.map_cursors( editor.cursor_right, nil, { select = false, by_word = false, create = false } )
end )

event.bind( "editor:key:alt-left", function( editor )
	editor.map_cursors( editor.cursor_left, nil, { select = false, by_word = false, create = true } )
end )

event.bind( "editor:key:alt-right", function( editor )
	editor.map_cursors( editor.cursor_right, nil, { select = false, by_word = false, create = true } )
end )

event.bind( "editor:key:ctrl-alt-left", function( editor )
	editor.map_cursors( editor.cursor_left, nil, { select = false, by_word = true, create = true } )
end )

event.bind( "editor:key:ctrl-alt-right", function( editor )
	editor.map_cursors( editor.cursor_right, nil, { select = false, by_word = true, create = true } )
end )

event.bind( "editor:key:shift-left", function( editor )
	editor.map_cursors( editor.cursor_left, nil, { select = true, by_word = false, create = false } )
end )

event.bind( "editor:key:shift-right", function( editor )
	editor.map_cursors( editor.cursor_right, nil, { select = true, by_word = false, create = false } )
end )

event.bind( "editor:key:ctrl-shift-left", function( editor )
	editor.map_cursors( editor.cursor_left, nil, { select = true, by_word = true, create = false } )
end )

event.bind( "editor:key:ctrl-shift-right", function( editor )
	editor.map_cursors( editor.cursor_right, nil, { select = true, by_word = true, create = false } )
end )

event.bind( "editor:key:ctrl-left", function( editor )
	editor.map_cursors( editor.cursor_left, nil, { select = false, by_word = true, create = false } )
end )

event.bind( "editor:key:ctrl-right", function( editor )
	editor.map_cursors( editor.cursor_right, nil, { select = false, by_word = true, create = false } )
end )

event.bind( "editor:key:backspace", function( editor )
	editor.map_cursors( editor.backspace )
end )

event.bind( "editor:key:tab", function( editor, text )
	editor.map_cursors( editor.write, nil, "\t" )
end )

event.bind( "editor:key:return", function( editor, text )
	editor.map_cursors( editor.write, nil, "\n" )
end )

event.bind( "editor:text", function( editor, text )
	editor.map_cursors( editor.write, nil, text )
end )
