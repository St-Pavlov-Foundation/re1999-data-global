module("modules.logic.versionactivity2_4.pinball.view.PinballResultView", package.seeall)

slot0 = class("PinballResultView", BaseView)

function slot0.onInitView(slot0)
	slot0._goFinish = gohelper.findChild(slot0.viewGO, "#go_finish")
	slot0._gonoFinish = gohelper.findChild(slot0.viewGO, "#go_noFinish")
	slot0._txttask = gohelper.findChildTextMesh(slot0.viewGO, "#go_finish/#txt_taskdes")
	slot0._txttask2 = gohelper.findChildTextMesh(slot0.viewGO, "#go_noFinish/#txt_taskdes")
	slot0._resexitem = gohelper.findChild(slot0.viewGO, "#go_finish/items_ex/item")
	slot0._resitem = gohelper.findChild(slot0.viewGO, "items/item")
end

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.Act178.act178_audio20)

	if not lua_activity178_episode.configDict[VersionActivity2_4Enum.ActivityId.Pinball][PinballModel.instance.leftEpisodeId] then
		return
	end

	slot0:updateTask(slot1)

	for slot9, slot10 in ipairs({
		PinballEnum.ResType.Wood,
		PinballEnum.ResType.Mine,
		PinballEnum.ResType.Stone,
		PinballEnum.ResType.Food
	}) do
		if slot0._isFinish and slot0._taskRewardDict[slot10] then
			table.insert({}, {
				resType = slot10,
				value = slot0._taskRewardDict[slot10]
			})
		end
	end

	gohelper.CreateObjList(slot0, slot0.createItem, {
		[slot9] = {
			resType = slot10,
			value = (PinballModel.instance.gameAddResDict[slot10] or 0) * (1 + PinballModel.instance:getResAdd(slot10))
		}
	}, nil, slot0._resitem)

	if slot0._isFinish then
		gohelper.CreateObjList(slot0, slot0.createItem, slot5, nil, slot0._resexitem)
	end
end

function slot0.updateTask(slot0, slot1)
	if not string.splitToNumber(slot1.target, "#") or #slot2 ~= 2 then
		logError("任务配置错误" .. slot1.id)

		return
	end

	slot0._isFinish = slot2[2] <= PinballModel.instance:getGameRes(slot2[1])

	gohelper.setActive(slot0._goFinish, slot0._isFinish)
	gohelper.setActive(slot0._gonoFinish, not slot0._isFinish)

	slot6 = ""

	if slot3 == 0 then
		slot6 = luaLang("pinball_any_res")
	elseif lua_activity178_resource.configDict[VersionActivity2_4Enum.ActivityId.Pinball][slot3] then
		slot6 = slot7.name
	end

	slot0._txttask.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("pinball_game_target2"), slot5, slot6)
	slot0._txttask2.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("pinball_game_target2"), slot5, slot6)

	if not slot0._isFinish then
		return
	end

	slot0._taskRewardDict = {}

	for slot11, slot12 in pairs(GameUtil.splitString2(slot1.reward, true) or {}) do
		slot0._taskRewardDict[slot12[1]] = slot12[2]
	end
end

function slot0.createItem(slot0, slot1, slot2, slot3)
	slot4 = gohelper.findChildImage(slot1, "#image_icon")
	gohelper.findChildTextMesh(slot1, "#txt_num").text = Mathf.Round(slot2.value)

	if not lua_activity178_resource.configDict[VersionActivity2_4Enum.ActivityId.Pinball][slot2.resType] then
		return
	end

	UISpriteSetMgr.instance:setAct178Sprite(slot4, slot6.icon)
end

function slot0.onClickModalMask(slot0)
	ViewMgr.instance:closeView(ViewName.PinballGameView)
	slot0:closeThis()
end

return slot0
