module("modules.logic.versionactivity2_5.challenge.view.Act183TaskItem", package.seeall)

slot0 = class("Act183TaskItem", Act183TaskBaseItem)

function slot0.init(slot0, slot1)
	uv0.super.init(slot0, slot1)

	slot0._txtdesc = gohelper.findChildText(slot0.go, "txt_desc")
	slot0._imagepoint = gohelper.findChildImage(slot0.go, "image_point")
	slot0._btncanget = gohelper.findChildButtonWithAudio(slot0.go, "btn_canget")
	slot0._gohasget = gohelper.findChild(slot0.go, "go_hasget")
	slot0._btnjump = gohelper.findChildButtonWithAudio(slot0.go, "btn_jump")
	slot0._goscrollcontent = gohelper.findChild(slot0.go, "scroll_reward/Viewport/Content")
	slot0._gorewarditem = gohelper.findChild(slot0.go, "scroll_reward/Viewport/Content/go_rewarditem")
end

function slot0.addEventListeners(slot0)
	uv0.super.addEventListeners(slot0)
	slot0._btncanget:AddClickListener(slot0._btncangetOnClick, slot0)
	slot0._btnjump:AddClickListener(slot0._btnjumpOnClick, slot0)
	slot0:addEventCb(Act183Controller.instance, Act183Event.ClickToGetReward, slot0._onReceiveGetRewardInfo, slot0)
end

function slot0.removeEventListeners(slot0)
	uv0.super.removeEventListeners(slot0)
	slot0._btncanget:RemoveClickListener()
	slot0._btnjump:RemoveClickListener()
end

function slot0._btncangetOnClick(slot0)
	if not slot0._canGet then
		return
	end

	slot0:setBlock(true)
	slot0._animatorPlayer:Play("finish", slot0._sendRpcToFinishTask, slot0)
end

function slot0._sendRpcToFinishTask(slot0)
	slot1 = slot0._taskId

	TaskRpc.instance:sendFinishTaskRequest(slot0._taskId, function (slot0, slot1)
		if slot1 ~= 0 then
			return
		end

		Act183Helper.showToastWhileCanTaskRewards({
			uv0
		})
	end)
	slot0:setBlock(false)
end

function slot0._btnjumpOnClick(slot0)
	GameFacade.jump(slot0._config.jumpId)
end

function slot0.onUpdateMO(slot0, slot1, slot2, slot3)
	uv0.super.onUpdateMO(slot0, slot1, slot2, slot3)

	slot0._taskMo = slot1.data
	slot0._config = slot1.data and slot1.data.config
	slot0._taskId = slot1.data and slot1.data.id
	slot0._canGet = Act183Helper.isTaskCanGetReward(slot0._taskId)
	slot0._hasGet = Act183Helper.isTaskHasGetReward(slot0._taskId)

	slot0:refresh()
end

function slot0.refresh(slot0)
	slot0._txtdesc.text = slot0._config.desc

	gohelper.setActive(slot0._btncanget.gameObject, slot0._canGet)
	gohelper.setActive(slot0._btnjump.gameObject, not slot0._canGet and not slot0._hasGet)
	gohelper.setActive(slot0._gohasget, slot0._hasGet)

	if not string.nilorempty(slot0._config.bonus) then
		table.insert({}, slot0:_generateBadgeItemConfig())

		for slot7, slot8 in ipairs(DungeonConfig.instance:getRewardItems(tonumber(slot0._config.bonus))) do
			table.insert(slot2, {
				isIcon = true,
				materilType = slot8[1],
				materilId = slot8[2],
				quantity = slot8[3]
			})
		end

		IconMgr.instance:getCommonPropItemIconList(slot0, slot0._onItemShow, slot2, slot0._goscrollcontent)
	else
		logError(string.format("任务缺少奖励配置 taskId = %s", slot0._config.id))
	end
end

function slot0._generateBadgeItemConfig(slot0)
	if slot0._config.badgeNum > 0 then
		slot1, slot2 = Act183Helper.getBadgeItemConfig()

		if slot1 and slot2 then
			slot0._badgeMaterilType = slot1
			slot0._badgeMaterilId = slot2

			return {
				isIcon = true,
				materilType = slot1,
				materilId = slot2,
				quantity = slot0._config.badgeNum
			}
		end
	end
end

function slot0._onItemShow(slot0, slot1, slot2, slot3)
	slot1:onUpdateMO(slot2)
	slot1:setConsume(true)
	slot1:showStackableNum2()
	slot1:isShowEffect(true)
	slot1:isShowQuality(true)
	slot1:setAutoPlay(true)
	slot1:setCountFontSize(48)
	slot1:customOnClickCallback(function ()
		if uv0.materilType == uv1._badgeMaterilType and uv0.materilId == uv1._badgeMaterilId then
			return
		end

		MaterialTipController.instance:showMaterialInfo(tonumber(uv0.materilType), uv0.materilId)
	end)
end

function slot0._onReceiveGetRewardInfo(slot0, slot1)
	if slot0._taskId ~= slot1 or not slot0.go.activeInHierarchy then
		return
	end

	slot0._animatorPlayer:Play("finish", function ()
	end, slot0)
end

return slot0
