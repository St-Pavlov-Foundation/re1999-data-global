module("modules.logic.ressplit.work.ResSplitAudioWemWork", package.seeall)

local var_0_0 = class("ResSplitAudioWemWork", BaseWork)

function var_0_0.onStart(arg_1_0, arg_1_1)
	local var_1_0 = io.open("../audios/Android/SoundbanksInfo.xml", "r")
	local var_1_1 = var_1_0:read("*a")

	var_1_0:close()
	ResSplitXml2lua.parser(ResSplitXmlTree):parse(var_1_1)
	ResSplitModel.instance:setExclude(ResSplitEnum.AudioWem, "ResSplitAudioWemWork_temp", false)

	local var_1_2 = {}

	for iter_1_0, iter_1_1 in ipairs(lua_bg_audio.configList) do
		if var_1_2[iter_1_1.bankName] == nil then
			var_1_2[iter_1_1.bankName] = {}
		end

		table.insert(var_1_2[iter_1_1.bankName], iter_1_1)
	end

	arg_1_0.bank2wenDic = {}
	arg_1_0.bankEvent2wenDic = {}
	arg_1_0.wen2BankDic = {}

	for iter_1_2, iter_1_3 in pairs(ResSplitXmlTree.root.SoundBanksInfo.SoundBanks.SoundBank) do
		arg_1_0:_dealSingleSoundBank(iter_1_3)
	end

	local var_1_3 = ResSplitModel.instance:getExcludeDic(ResSplitEnum.CommonAudioBank)

	for iter_1_4, iter_1_5 in pairs(var_1_3) do
		if iter_1_5 == true then
			if arg_1_0.bank2wenDic[iter_1_4] then
				for iter_1_6, iter_1_7 in pairs(arg_1_0.bank2wenDic[iter_1_4]) do
					arg_1_0.wen2BankDic[iter_1_7][iter_1_4] = nil
				end
			end

			var_1_2[iter_1_4] = nil
		end
	end

	local var_1_4 = {}

	for iter_1_8, iter_1_9 in pairs(arg_1_0.wen2BankDic) do
		if tabletool.len(iter_1_9) == 0 then
			ResSplitModel.instance:setExclude(ResSplitEnum.AudioWem, iter_1_8, true)

			var_1_4[iter_1_8] = true
		end
	end

	local var_1_5 = {
		[AudioEnum.Default_UI_Bgm] = true,
		[AudioEnum.Default_UI_Bgm_Stop] = true,
		[AudioEnum.Default_Fight_Bgm] = true,
		[AudioEnum.Default_Fight_Bgm_Stop] = true,
		[AudioEnum.UI.Play_Login_interface_nosie] = true,
		[AudioEnum.UI.Stop_Login_interface_noise] = true,
		[AudioEnum.UI.Play_Login_interface_noise_1_9] = true,
		[AudioEnum.UI.Stop_Login_interface_noise_1_9] = true
	}
	local var_1_6 = {}

	for iter_1_10, iter_1_11 in pairs(var_1_2) do
		for iter_1_12, iter_1_13 in pairs(iter_1_11) do
			if iter_1_13 then
				local var_1_7 = iter_1_13.bankName .. "#" .. iter_1_13.eventName

				if arg_1_0.bankEvent2wenDic[var_1_7] then
					for iter_1_14, iter_1_15 in pairs(arg_1_0.bankEvent2wenDic[var_1_7]) do
						if var_1_4[iter_1_15] == nil then
							ResSplitModel.instance:setExclude(ResSplitEnum.InnerAudioWem, iter_1_15, var_1_5[iter_1_13.id] ~= true)
						end
					end
				end
			end
		end
	end

	arg_1_0:_dealActivitySoundBank()
	arg_1_0:onDone(true)
end

function var_0_0._dealActivitySoundBank(arg_2_0)
	local var_2_0 = SLFramework.FileHelper.GetDirFilePaths(SLFramework.FrameworkSettings.AssetRootDir .. "/../../../audios/iOS/", false)
	local var_2_1 = {}

	for iter_2_0 = 0, var_2_0.Length - 1 do
		local var_2_2 = var_2_0[iter_2_0]

		if string.find(var_2_2, "ui_activity", 1, true) == 1 or string.find(var_2_2, "activity", 1, true) then
			local var_2_3 = SLFramework.FileHelper.GetFileName(var_2_2, false)

			table.insert(var_2_1, var_2_3)
		end
	end

	for iter_2_1, iter_2_2 in ipairs(var_2_1) do
		ResSplitModel.instance:setExclude(ResSplitEnum.CommonAudioBank, iter_2_2, true)

		local var_2_4 = arg_2_0.bank2wenDic[iter_2_2]

		if var_2_4 then
			for iter_2_3, iter_2_4 in ipairs(var_2_4) do
				ResSplitModel.instance:setExclude(ResSplitEnum.AudioWem, iter_2_4, true)
			end
		end
	end
end

function var_0_0._dealSingleSoundBank(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_1.ShortName
	local var_3_1 = arg_3_1.Path

	if arg_3_1._attr.Language == "SFX" and arg_3_1.IncludedEvents then
		for iter_3_0, iter_3_1 in pairs(arg_3_1.IncludedEvents.Event) do
			local var_3_2 = iter_3_1._attr.Name

			if iter_3_1.ReferencedStreamedFiles then
				for iter_3_2, iter_3_3 in pairs(iter_3_1.ReferencedStreamedFiles.File) do
					arg_3_0:_addWenInfo(var_3_0, var_3_2, iter_3_3._attr.Id)
				end
			end
		end
	end
end

function var_0_0._addWenInfo(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	if arg_4_0.bank2wenDic[arg_4_1] == nil then
		arg_4_0.bank2wenDic[arg_4_1] = {}
	end

	table.insert(arg_4_0.bank2wenDic[arg_4_1], arg_4_3)

	local var_4_0 = arg_4_1 .. "#" .. arg_4_2

	if arg_4_0.bankEvent2wenDic[var_4_0] == nil then
		arg_4_0.bankEvent2wenDic[var_4_0] = {}
	end

	table.insert(arg_4_0.bankEvent2wenDic[var_4_0], arg_4_3)

	if arg_4_0.wen2BankDic[arg_4_3] == nil then
		arg_4_0.wen2BankDic[arg_4_3] = {}
	end

	arg_4_0.wen2BankDic[arg_4_3][arg_4_1] = true
end

return var_0_0
