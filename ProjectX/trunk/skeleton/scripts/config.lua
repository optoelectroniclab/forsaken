-- vim:set sw=4 ts=4:
--
-- Copyright (C) 2009  Daniel Aquino
--
-- Redistribution and use in source and binary forms, with or without
-- modification, are permitted provided that the following conditions
-- are met:
-- 
-- 1. Redistributions of source code must retain the above copyright
--    notice, this list of conditions and the following disclaimer.
-- 2. Redistributions in binary form must reproduce the above copyright
--    notice, this list of conditions and the following disclaimer in the
--    documentation and/or other materials provided with the distribution.
-- 3. The name of the author may not be used to endorse or promote
--    products derived from this software without specific prior written
--    permission.
-- 
-- THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR
-- IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
-- WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
-- ARE DISCLAIMED. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT,
-- INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
-- (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
-- SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
-- HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
-- STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING
-- IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
-- POSSIBILITY OF SUCH DAMAGE.

function config_path(name)
	return "configs/"..name..".txt"
end

function config_load(name)
	local cfg = {}
	local path = config_path(name)
	touch_file(path)
	setfenv(load_file(path), cfg)()
	for key, value in pairs(cfg) do
		config[key] = value
	end
end

function config_save(name)
	local f = io.open(config_path(name), 'wb')
	for key, value in table.pairsByKeys(config) do
		if type(value) == "string" then
			f:write(("%s = %q\r\n"):format(key, value))
		else
			f:write(key.." = "..tostring(value).."\r\n")
		end
	end
	f:close()
end

