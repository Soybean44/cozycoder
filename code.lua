local program, err

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
