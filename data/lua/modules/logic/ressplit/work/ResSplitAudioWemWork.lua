module("modules.logic.ressplit.work.ResSplitAudioWemWork", package.seeall)

slot0 = class("ResSplitAudioWemWork", BaseWork)

function slot0.onStart(slot0, slot1)
	slot2 = io.open("../audios/Android/SoundbanksInfo.xml", "r")

	slot2:close()
	ResSplitXml2lua.parser(ResSplitXmlTree):parse(slot2:read("*a"))

	slot9 = false

	ResSplitModel.instance:setExclude(ResSplitEnum.AudioWem, "ResSplitAudioWemWork_temp", slot9)

	slot5 = {}

	for slot9, slot10 in ipairs(lua_bg_audio.configList) do
		if slot5[slot10.bankName] == nil then
			slot5[slot10.bankName] = {}
		end

		table.insert(slot5[slot10.bankName], slot10)
	end

	slot0.bank2wenDic = {}
	slot0.bankEvent2wenDic = {}
	slot0.wen2BankDic = {}

	for slot9, slot10 in pairs(ResSplitXmlTree.root.SoundBanksInfo.SoundBanks.SoundBank) do
		slot0:_dealSingleSoundBank(slot10)
	end

	for slot10, slot11 in pairs(ResSplitModel.instance:getExcludeDic(ResSplitEnum.CommonAudioBank)) do
		if slot11 == true then
			if slot0.bank2wenDic[slot10] then
				for slot15, slot16 in pairs(slot0.bank2wenDic[slot10]) do
					slot0.wen2BankDic[slot16][slot10] = nil
				end
			end

			slot5[slot10] = nil
		end
	end

	slot7 = {
		[slot11] = true
	}

	for slot11, slot12 in pairs(slot0.wen2BankDic) do
		if tabletool.len(slot12) == 0 then
			ResSplitModel.instance:setExclude(ResSplitEnum.AudioWem, slot11, true)
		end
	end

	slot8 = {
		[AudioEnum.Default_UI_Bgm] = true,
		[AudioEnum.Default_UI_Bgm_Stop] = true,
		[AudioEnum.Default_Fight_Bgm] = true,
		[AudioEnum.Default_Fight_Bgm_Stop] = true,
		[AudioEnum.UI.Play_Login_interface_nosie] = true,
		[AudioEnum.UI.Stop_Login_interface_noise] = true,
		[AudioEnum.UI.Play_Login_interface_noise_1_9] = true,
		[AudioEnum.UI.Stop_Login_interface_noise_1_9] = true
	}
	slot9 = {}

	for slot13, slot14 in pairs(slot5) do
		for slot18, slot19 in pairs(slot14) do
			if slot19 and slot0.bankEvent2wenDic[slot19.bankName .. "#" .. slot19.eventName] then
				for slot24, slot25 in pairs(slot0.bankEvent2wenDic[slot20]) do
					if slot7[slot25] == nil then
						ResSplitModel.instance:setExclude(ResSplitEnum.InnerAudioWem, slot25, slot8[slot19.id] ~= true)
					end
				end
			end
		end
	end

	slot0:onDone(true)
end

function slot0._dealSingleSoundBank(slot0, slot1)
	slot2 = slot1.ShortName
	slot3 = slot1.Path

	if slot1._attr.Language == "SFX" and slot1.IncludedEvents then
		for slot7, slot8 in pairs(slot1.IncludedEvents.Event) do
			slot9 = slot8._attr.Name

			if slot8.ReferencedStreamedFiles then
				for slot13, slot14 in pairs(slot8.ReferencedStreamedFiles.File) do
					slot0:_addWenInfo(slot2, slot9, slot14._attr.Id)
				end
			end
		end
	end
end

function slot0._addWenInfo(slot0, slot1, slot2, slot3)
	if slot0.bank2wenDic[slot1] == nil then
		slot0.bank2wenDic[slot1] = {}
	end

	table.insert(slot0.bank2wenDic[slot1], slot3)

	if slot0.bankEvent2wenDic[slot1 .. "#" .. slot2] == nil then
		slot0.bankEvent2wenDic[slot4] = {}
	end

	table.insert(slot0.bankEvent2wenDic[slot4], slot3)

	if slot0.wen2BankDic[slot3] == nil then
		slot0.wen2BankDic[slot3] = {}
	end

	slot0.wen2BankDic[slot3][slot1] = true
end

return slot0
