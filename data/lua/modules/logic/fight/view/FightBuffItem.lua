module("modules.logic.fight.view.FightBuffItem", package.seeall)

slot0 = class("FightBuffItem", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0.tr = slot1.transform
	slot0._imgIcon = gohelper.findChildImage(slot1, "icon")
	slot0._txtBadBuff = gohelper.findChildText(slot1, "badText")
	slot0._txtGoodBuff = gohelper.findChildText(slot1, "goodText")
	slot0._txtBadCount = gohelper.findChildText(slot1, "badText_count")
	slot0._txtGoodCount = gohelper.findChildText(slot1, "goodText_count")
	slot0._bgIcon = gohelper.findChildImage(slot1, "bg")
	slot0.bgeffect = gohelper.findChild(slot1, "bgeffect")
	slot0.buffquan = gohelper.findChild(slot1, "buffquan")
	slot0.bufffinish = gohelper.findChild(slot1, "bufffinish")
	slot0.buffdot = gohelper.findChild(slot1, "buffdot")
	slot0._animator = slot1:GetComponent(typeof(UnityEngine.Animator))
	slot0._click = gohelper.getClick(slot1)

	gohelper.addUIClickAudio(slot1, AudioEnum.UI.UI_Common_Click)

	slot0._tipsOffsetX = 0
	slot0._tipsOffsetY = 0

	slot0:closeAni()
end

function slot0.addEventListeners(slot0)
	slot0._click:AddClickListener(slot0._onClick, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0._click:RemoveClickListener()
end

function slot0.setClickCallback(slot0, slot1, slot2)
	slot0._callback = slot1
	slot0._callbackObj = slot2
end

function slot0._onClick(slot0)
	if FightModel.instance:getCurStage() ~= FightEnum.Stage.Card then
		return
	end

	if not FightDataHelper.stageMgr:isFree() then
		return
	end

	if slot0._callback then
		slot0._callback(slot0._callbackObj, slot0.buffMO.entityId)
	else
		FightController.instance:dispatchEvent(FightEvent.OnBuffClick, slot0.buffMO.entityId, slot0.tr, slot0._tipsOffsetX, slot0._tipsOffsetY)
	end
end

function slot0.setTipsOffset(slot0, slot1, slot2)
	slot0._tipsOffsetX = slot1
	slot0._tipsOffsetY = slot2
end

function slot0.updateBuffMO(slot0, slot1)
	if slot0.buffMO and slot0.buffMO.buffId ~= slot1.buffId and not FightHelper.shouUIPoisoningEffect(slot1.buffId) then
		slot0:_hidePoisoningEffect()
	end

	slot0.buffMO = slot1

	if lua_skill_buff.configDict[slot1.buffId] then
		gohelper.onceAddComponent(slot0.go, gohelper.Type_CanvasGroup).alpha = 1

		if string.nilorempty(slot2.iconId) or slot3 == "0" then
			logError(string.format("try show buff icon, but buffId : %s, buffName : %s, buffIconId : %s", slot2.id, slot2.name, slot3))
		else
			UISpriteSetMgr.instance:setBuffSprite(slot0._imgIcon, slot2.iconId)
		end

		slot0:refreshTxt(slot1, slot2)

		if slot0:isTimeBuff(slot2) then
			gohelper.setActive(slot0._bgIcon.gameObject, true)
			UISpriteSetMgr.instance:setFightSprite(slot0._bgIcon, "buff_jishiqi_" .. slot0:calculateBuffType(lua_skill_bufftype.configDict[slot2.typeId].type))
		elseif slot4.cannotRemove then
			UISpriteSetMgr.instance:setFightSprite(slot0._bgIcon, "buff_bukechexiao_" .. slot0:calculateBuffType(slot4.type))
			gohelper.setActive(slot0._bgIcon.gameObject, true)
		else
			gohelper.setActive(slot0._bgIcon.gameObject, false)
		end
	else
		logError("buff config not exist, id = " .. slot1.buffId)
	end
end

function slot0.getBuffGoodText(slot0, slot1)
	if not slot1 then
		return ""
	end

	if FightBuffHelper.isCountContinueChanelBuff(slot1) then
		return slot1.exInfo
	end

	if slot1.duration > 0 then
		return slot1.duration
	end

	return ""
end

function slot0.refreshTxt(slot0, slot1, slot2)
	if FightBuffHelper.isDeadlyPoisonBuff(slot1) then
		slot0:refreshDeadlyPoisonTxt(slot1, slot2)

		return
	end

	if FightBuffHelper.isDuduBoneContinueChannelBuff(slot1) then
		slot0:refreshDuduBoneContinueChannelTxt(slot1, slot2)

		return
	end

	if slot2.isGoodBuff == 1 then
		gohelper.setActive(slot0._txtGoodBuff.gameObject, true)
		gohelper.setActive(slot0._txtGoodCount.gameObject, true)
		gohelper.setActive(slot0._txtBadBuff.gameObject, false)
		gohelper.setActive(slot0._txtBadCount.gameObject, false)

		if FightSkillBuffMgr.instance:buffIsStackerBuff(slot2) then
			slot0._txtGoodBuff.text = ""
			slot0._txtGoodCount.text = FightSkillBuffMgr.instance:getStackedCount(slot1.entityId, slot1)
		else
			slot0._txtGoodBuff.text = slot0:getBuffGoodText(slot1)

			if slot1.layer and slot1.layer > 0 then
				slot0._txtGoodCount.text = slot1.layer
			else
				slot0._txtGoodCount.text = slot1.count > 0 and slot1.count or ""
			end
		end
	else
		gohelper.setActive(slot0._txtGoodBuff.gameObject, false)
		gohelper.setActive(slot0._txtGoodCount.gameObject, false)
		gohelper.setActive(slot0._txtBadBuff.gameObject, true)
		gohelper.setActive(slot0._txtBadCount.gameObject, true)

		slot3, slot4 = FightSkillBuffMgr.instance:buffIsStackerBuff(slot2)

		if slot3 then
			slot0._txtBadBuff.text = ""

			if slot4 == FightEnum.BuffIncludeTypes.Stacked12 then
				slot0._txtBadBuff.text = slot1.duration > 0 and slot1.duration or ""
			end

			slot0._txtBadCount.text = FightSkillBuffMgr.instance:getStackedCount(slot1.entityId, slot1)
		else
			slot0._txtBadBuff.text = slot1.duration > 0 and slot1.duration or ""

			if slot1.layer and slot1.layer > 0 then
				slot0._txtBadCount.text = slot1.layer
			else
				slot0._txtBadCount.text = slot1.count > 0 and slot1.count or ""
			end
		end
	end
end

function slot0.refreshDeadlyPoisonTxt(slot0, slot1, slot2)
	gohelper.setActive(slot0._txtGoodBuff.gameObject, false)
	gohelper.setActive(slot0._txtGoodCount.gameObject, false)
	gohelper.setActive(slot0._txtBadBuff.gameObject, true)
	gohelper.setActive(slot0._txtBadCount.gameObject, true)

	slot0._txtBadBuff.text = slot1.duration > 0 and slot1.duration or ""
	slot0._txtBadCount.text = FightSkillBuffMgr.instance:getStackedCount(slot1.entityId, slot1)
end

function slot0.refreshDuduBoneContinueChannelTxt(slot0, slot1, slot2)
	gohelper.setActive(slot0._txtGoodBuff.gameObject, true)
	gohelper.setActive(slot0._txtGoodCount.gameObject, true)
	gohelper.setActive(slot0._txtBadBuff.gameObject, false)
	gohelper.setActive(slot0._txtBadCount.gameObject, false)

	slot0._txtGoodBuff.text = slot1.exInfo
	slot0._txtGoodCount.text = ""
end

function slot0.calculateBuffType(slot0, slot1)
	for slot5, slot6 in ipairs(FightEnum.BuffTypeList.GoodBuffList) do
		if slot1 == slot6 then
			return FightEnum.FightBuffType.GoodBuff
		end
	end

	for slot5, slot6 in ipairs(FightEnum.BuffTypeList.BadBuffList) do
		if slot1 == slot6 then
			return FightEnum.FightBuffType.BadBuff
		end
	end

	return FightEnum.FightBuffType.NormalBuff
end

function slot0.isTimeBuff(slot0, slot1)
	if string.nilorempty(slot1.features) then
		return false
	end

	slot4 = nil

	for slot8, slot9 in ipairs(FightStrUtil.instance:getSplitCache(slot2, "|")) do
		if #FightStrUtil.instance:getSplitToNumberCache(slot9, "#") >= 2 and slot4[1] == 702 and slot4[2] > 2 then
			return true
		end
	end

	return false
end

function slot0.showPoisoningEffect(slot0)
	slot0:playAni("buffeffect")
end

function slot0._hidePoisoningEffect(slot0)
	slot0:closeAni()
end

function slot0.playAni(slot0, slot1)
	slot2 = FightModel.instance:getUISpeed()
	slot0._animator.enabled = true
	slot0._animator.speed = slot2

	slot0._animator:Play(slot1, 0, 0)

	slot4 = slot0._animator:GetCurrentAnimatorStateInfo(0).length / slot2

	TaskDispatcher.runDelay(slot0.closeAni, slot0, slot4)

	return slot4
end

function slot0.closeAni(slot0)
	if not slot0._animator then
		return
	end

	slot0._animator.enabled = false

	ZProj.UGUIHelper.SetColorAlpha(slot0._imgIcon, 1)

	gohelper.onceAddComponent(slot0.go, gohelper.Type_CanvasGroup).alpha = 1

	gohelper.setActive(slot0.bgeffect, false)
	gohelper.setActive(slot0.buffquan, false)
	gohelper.setActive(slot0.bufffinish, false)
	gohelper.setActive(slot0.buffdot, false)
	transformhelper.setLocalScale(slot0._txtBadBuff.transform, 0.4, 0.4, 1)
	transformhelper.setLocalScale(slot0._txtGoodBuff.transform, 0.4, 0.4, 1)
	transformhelper.setLocalScale(slot0._txtBadCount.transform, 0.4, 0.4, 1)
	transformhelper.setLocalScale(slot0._txtGoodCount.transform, 0.4, 0.4, 1)
end

function slot0.onDestroy(slot0)
	slot0._imgIcon = nil
	slot0._callback = nil
	slot0._callbackObj = nil

	TaskDispatcher.cancelTask(slot0._hidePoisoningEffect, slot0)
	TaskDispatcher.cancelTask(slot0.closeAni, slot0)
end

return slot0
