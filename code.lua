local program, err

-- Define the keywords and their corresponding colors
local keywords = {
	["function"] = { 0, 0, 1 }, -- Red
	["end"] = { 0, 0, 1 }, -- Green
	["print"] = { 1, 0, 0 }, -- Blue
}
function tokenizeString(str)
	local tokens = {}
	local state = "none"
	local token = ""

	for i = 1, #str do
		local char = str:sub(i, i)

		if state == "none" then
			if char:match("%s") then
				-- Ignore whitespace
			elseif char:match("%w") then
				-- Start a new word token
				token = char
				state = "word"
			elseif char:match("%p") then
				-- Start a new punctuation token
				token = char
				state = "punctuation"
			elseif char:match("%d") then
				-- Start a new number token
				token = char
				state = "number"
			elseif char == '"' then
				-- Start a new quoted string token
				token = ""
				state = "quoted_string"
			end
		elseif state == "word" then
			if char:match("%w") then
				-- Continue the word token
				token = token .. char
			else
				-- End the word token
				table.insert(tokens, token)
				token = ""
				state = "none"
				i = i - 1
			end
		elseif state == "punctuation" then
			if char:match("%p") then
				-- Continue the punctuation token
				token = token .. char
			else
				-- End the punctuation token
				table.insert(tokens, token)
				token = ""
				state = "none"
				i = i - 1
			end
		elseif state == "number" then
			if char:match("%d") then
				-- Continue the number token
				token = token .. char
			elseif char == "." then
				-- Continue the number token
				token = token .. char
			else
				-- End the number token
				table.insert(tokens, token)
				token = ""
				state = "none"
				i = i - 1
			end
		elseif state == "quoted_string" then
			if char == '"' then
				-- End the quoted string token
				table.insert(tokens, token)
				token = ""
				state = "none"
			elseif char == "\\" then
				-- Handle escaped characters
				local nextChar = str:sub(i + 1, i + 1)
				if nextChar == "n" then
					token = token .. "\n"
				elseif nextChar == "t" then
					token = token .. "\t"
				elseif nextChar == "\\" then
					token = token .. "\\"
				elseif nextChar == '"' then
					token = token .. '"'
				end
				i = i + 1
			else
				-- Continue the quoted string token
				token = token .. char
			end
		end
	end

	if token ~= "" then
		table.insert(tokens, token)
	end

	return tokens
end

function hightlight(code)
	local colored_text = {}
	local tokens = tokenizeString(code)
	for _, token in ipairs(tokens) do
		print(token)
		if keywords[token] then
			table.insert(colored_text, keywords[token])
			table.insert(colored_text, token)
		else
			table.insert(colored_text, { 1, 1, 1 })
			table.insert(colored_text, token)
		end
	end
	return colored_text
end

function load_code(code, environment)
	if setfenv and loadstring then
		program, err = loadstring(code)
		if program then
			setfenv(program, environment)
		else
		end
	else
		return assert(load(code, nil, "t", environment))
	end
end

function run_code()
	if program then
		if not pcall(program) then
			print("THE USER IS TRYING TO HACK US HELPPPP!!!")
		end
	else
		print(err)
	end
end
