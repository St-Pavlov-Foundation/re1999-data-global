module("modules.logic.versionactivity2_2.act173.view.Activity173TaskItem", package.seeall)

slot0 = class("Activity173TaskItem", LuaCompBase)
slot1 = "#392E0F"
slot2 = 0.5
slot3 = "#392E0F"
slot4 = 1
slot5 = "#A5471B"
slot6 = "#392E0F"

function slot0.ctor(slot0, slot1)
	uv0.super.ctor(slot0)

	slot0.go = slot1
	slot0._txtTitle = gohelper.findChildText(slot0.go, "Title/#txt_Title")
	slot0._txtDescr = gohelper.findChildText(slot0.go, "#txt_Descr")
	slot0._txtNum = gohelper.findChildText(slot0.go, "image_NumBG/txt_Num")
	slot0._txtProgress = gohelper.findChildText(slot0.go, "#txt_Num")
	slot0._goClaim = gohelper.findChild(slot0.go, "#go_Claim")
	slot0._goGet = gohelper.findChild(slot0.go, "#go_Get")
	slot0._btnclick = gohelper.findChildButtonWithAudio(slot0.go, "#btn_click")
	slot0._simageHeadIcon = gohelper.findChildSingleImage(slot0.go, "#simage_HeadIcon")
	slot0._btnjump = gohelper.findChildButtonWithAudio(slot0.go, "#btn_jump")

	slot0:addEvents()
end

function slot0.init(slot0, slot1)
	slot0._config = slot1

	slot0:initTaskDesc()
	slot0:initReward()
end

function slot0.addEvents(slot0)
	slot0._btnclick:AddClickListener(slot0._btnclickOnClick, slot0)
	slot0._btnjump:AddClickListener(slot0._btnjumpOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclick:RemoveClickListener()
	slot0._btnjump:RemoveClickListener()
end

function slot0._btnclickOnClick(slot0)
	if slot0._config and slot0._canGetReward then
		TaskRpc.instance:sendFinishTaskRequest(slot0._config.id, slot0._onFinishedTask, slot0)

		return
	end

	if not slot0._bonus or #slot0._bonus <= 0 then
		logError("打开物品详情界面失败:缺少奖励配置 任务Id = " .. tostring(slot0._config and slot0._config.id))

		return
	end

	MaterialTipController.instance:showMaterialInfo(slot0._bonus[1], slot0._bonus[2])
end

function slot0._btnjumpOnClick(slot0)
	if slot0._config and slot0._config.jumpId ~= 0 then
		JumpController.instance:jump(slot0._config.jumpId)
	end
end

function slot0.initTaskDesc(slot0)
	slot0._txtDescr.text = slot0._config.desc
	slot0._txtTitle.text = slot0._config.name
end

function slot0.initReward(slot0)
	slot0._bonus = string.splitToNumber(slot0._config.bonus, "#")
	slot0._txtNum.text = luaLang("multiple") .. (slot0._bonus[3] or 0)

	slot0:initOrRefreshProgress()

	if slot0:checkIsPortraitReward(slot0._bonus) and slot0._simageHeadIcon then
		if not slot0._liveHeadIcon then
			slot0._liveHeadIcon = IconMgr.instance:getCommonLiveHeadIcon(slot0._simageHeadIcon)
		end

		slot0._liveHeadIcon:setLiveHead(tonumber(slot0._bonus[2]))
	end
end

function slot0.refresh(slot0)
	slot0._taskMo = TaskModel.instance:getTaskById(slot0._config.id)
	slot1 = slot0._taskMo and slot0._taskMo.finishCount > 0
	slot2 = slot0._taskMo and slot0._taskMo.progress or 0
	slot0._canGetReward = slot0._taskMo and slot0._config.maxProgress <= slot2 and slot0._taskMo.finishCount <= 0

	gohelper.setActive(slot0._goClaim, slot0._canGetReward)
	gohelper.setActive(slot0._goGet, slot1)
	gohelper.setActive(slot0._btnjump.gameObject, not slot1)
	slot0:initOrRefreshTaskContentColor(slot1)
	slot0:initOrRefreshProgress(slot1, slot2)
end

function slot0.initOrRefreshTaskContentColor(slot0, slot1)
	SLFramework.UGUI.GuiHelper.SetColor(slot0._txtDescr, slot1 and uv0 or uv1)
	ZProj.UGUIHelper.SetColorAlpha(slot0._txtDescr, slot1 and uv2 or uv3)
end

function slot0.initOrRefreshProgress(slot0, slot1, slot2)
	slot0._txtProgress.text = string.format("<%s>%s</color>/%s", slot1 and uv0 or uv1, Activity173Controller.numberDisplay(slot2 or 0), Activity173Controller.numberDisplay(slot0._config.maxProgress))

	SLFramework.UGUI.GuiHelper.SetColor(slot0._txtProgress, slot1 and uv2 or uv3)
	ZProj.UGUIHelper.SetColorAlpha(slot0._txtProgress, slot1 and uv4 or uv5)
end

function slot0.checkIsPortraitReward(slot0, slot1)
	if slot1[1] == MaterialEnum.MaterialType.Item and ItemModel.instance:getItemConfig(slot2, slot1[2]) and slot4.subType == ItemEnum.SubType.Portrait then
		return true
	end
end

function slot0._onFinishedTask(slot0)
	slot0:refresh()
end

function slot0.destroy(slot0)
	slot0:removeEvents()
end

return slot0
