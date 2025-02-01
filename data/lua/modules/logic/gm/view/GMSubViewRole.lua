module("modules.logic.gm.view.GMSubViewRole", package.seeall)

slot0 = class("GMSubViewRole", GMSubViewBase)

function slot0.ctor(slot0)
	slot0.tabName = "角色"
end

function slot0.initViewContent(slot0)
	if slot0._inited then
		return
	end

	GMSubViewBase.initViewContent(slot0)

	slot0._inpDuration = slot0:addInputText("L1", "", "刷新间隔", nil, , {
		w = 200
	})
	slot0._inpSkins = slot0:addInputText("L1", "", "皮肤id#皮肤id", nil, , {
		w = 600
	})

	slot0:addButton("L1", "主界面测试皮肤", slot0._onClickShowAllSkins, slot0)

	slot0._playVoiceToggle = slot0:addToggle("L1", "播放语音")

	slot0:addButton("L2", "停止测试皮肤", slot0._onStopShowAllSkins, slot0)
end

function slot0._onStopShowAllSkins(slot0)
	TaskDispatcher.cancelTask(slot0._checkSkinAndVoice, slot0)
end

function slot0._onClickShowAllSkins(slot0)
	print(string.format("====开始播放,间隔为：%ss====", tonumber(slot0._inpDuration:GetText()) or 1.5))
	gohelper.setActive(slot0._subViewGo, false)

	slot0._index = 1
	slot0._skinList = {}

	if not slot0:_initInputSkins() then
		for slot5, slot6 in ipairs(lua_skin.configList) do
			if HeroConfig.instance:getHeroCO(slot6.characterId) then
				table.insert(slot0._skinList, slot6)
			end
		end
	end

	slot0._skinNum = #slot0._skinList

	TaskDispatcher.cancelTask(slot0._checkSkinAndVoice, slot0)
	TaskDispatcher.runRepeat(slot0._checkSkinAndVoice, slot0, slot1)
	slot0:_showSkin()
end

function slot0._initInputSkins(slot0)
	if string.nilorempty(slot0._inpSkins:GetText()) then
		return
	end

	if #string.splitToNumber(slot1, "#") == 1 then
		for slot7, slot8 in ipairs(lua_skin.configList) do
			if HeroConfig.instance:getHeroCO(slot8.characterId) then
				table.insert(slot0._skinList, slot8)

				if slot8.id == slot2[1] then
					slot0._index = #slot0._skinList
				end
			end
		end

		return true
	end

	for slot6, slot7 in ipairs(slot2) do
		table.insert(slot0._skinList, lua_skin.configDict[slot7])
	end

	return true
end

function slot0._showSkin(slot0)
	slot1 = slot0._skinList[slot0._index]

	print(string.format("==========================================auto showSkin %s skinId:%s progress:%s/%s", slot1.name, slot1.id, slot0._index, slot0._skinNum))

	slot0._index = slot0._index + 1

	MainController.instance:dispatchEvent(MainEvent.ChangeMainHeroSkin, slot1, true)

	slot0._skinCo = slot1

	if slot0._playVoiceToggle.isOn then
		slot0._voiceList = slot0:_getCharacterVoicesCO(slot1.characterId, slot1.id)
		slot0._voiceLen = slot0._voiceList and #slot0._voiceList or 0
	end
end

function slot0._checkSkinAndVoice(slot0)
	if slot0:_checkPlayVoice() then
		return
	end

	slot0:_checkShowSkin()
end

function slot0._checkShowSkin(slot0)
	if slot0._skinNum < slot0._index then
		print("====结束播放====")
		gohelper.setActive(slot0._subViewGo, true)
		TaskDispatcher.cancelTask(slot0._checkSkinAndVoice, slot0)

		return
	end

	slot0:_showSkin()
end

function slot0._checkPlayVoice(slot0)
	if not slot0._voiceList or #slot0._voiceList == 0 then
		return
	end

	slot1 = table.remove(slot0._voiceList, 1)

	print(string.format("======auto playVoice skinId:%s audio:%s name:%s progress:%s/%s", slot0._skinCo.id, slot1.audio, slot1.name, slot0._voiceLen - #slot0._voiceList, slot0._voiceLen))
	ViewMgr.instance:getContainer(ViewName.MainView):getMainHeroView():onlyPlayVoice(slot1)

	return true
end

function slot0._getCharacterVoicesCO(slot0, slot1, slot2)
	slot3 = {}

	if lua_character_voice.configDict[slot1] then
		for slot8, slot9 in pairs(slot4) do
			if CharacterDataConfig.instance:_checkSkin(slot9, slot2) then
				table.insert(slot3, slot9)
			end
		end
	end

	return slot3
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0._checkSkinAndVoice, slot0)
end

return slot0
