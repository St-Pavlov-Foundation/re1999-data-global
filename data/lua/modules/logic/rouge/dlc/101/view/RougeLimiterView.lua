module("modules.logic.rouge.dlc.101.view.RougeLimiterView", package.seeall)

slot0 = class("RougeLimiterView", BaseView)
slot0.DefaultBackgroundImageName = "rouge_dlc1_fullbg1"
slot1 = {
	Locked2Unlocked = "light",
	Unlocked = "idle",
	Locked = "idlegray"
}
slot2 = {
	"idle",
	"1to2",
	"2to3",
	"3to4",
	Default = "idle",
	[5.0] = "4to5"
}
slot3 = {
	Positive = 1,
	Reverse = -1
}
slot4 = {
	[slot3.Positive] = 0,
	[slot3.Reverse] = 1
}
slot5 = {
	[slot2[1]] = AudioEnum.UI.LimiterStageChanged_1,
	[slot2[2]] = AudioEnum.UI.LimiterStageChanged_2,
	[slot2[3]] = AudioEnum.UI.LimiterStageChanged_3,
	[slot2[4]] = AudioEnum.UI.LimiterStageChanged_4,
	[slot2[5]] = AudioEnum.UI.LimiterStageChanged_5
}

function slot0.onInitView(slot0)
	slot0._gobuffdec = gohelper.findChild(slot0.viewGO, "#go_buffdec")
	slot0._gochoosebuff = gohelper.findChild(slot0.viewGO, "#go_choosebuff")
	slot0._gosmallbuffitem = gohelper.findChild(slot0.viewGO, "#go_choosebuff/SmallBuffView/Viewport/Content/#go_smallbuffitem")
	slot0._golimiteritem = gohelper.findChild(slot0.viewGO, "Right/#go_limiteritem")
	slot0._goRightTop = gohelper.findChild(slot0.viewGO, "#go_RightTop")
	slot0._txtpoint = gohelper.findChildText(slot0.viewGO, "#go_RightTop/point/#txt_point")
	slot0._btnclick = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_RightTop/point/#btn_click")
	slot0._goLeftTop = gohelper.findChild(slot0.viewGO, "#go_LeftTop")
	slot0._btnreset = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_RightTop/#btn_reset")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnreset:AddClickListener(slot0._btnresetOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnreset:RemoveClickListener()
end

function slot0._btnresetOnClick(slot0)
	if not RougeDLCModel101.instance:getSelectLimiterGroupIds() or #slot1 <= 0 then
		return
	end

	RougeDLCModel101.instance:resetAllSelectLimitIds()
	RougeDLCController101.instance:openRougeLimiterView()
end

function slot0._editableInitView(slot0)
	gohelper.addUIClickAudio(slot0._btnreset.gameObject, AudioEnum.UI.ResetRougeLimiter)
	slot0:addEventCb(RougeDLCController101.instance, RougeDLCEvent101.UpdateLimitGroup, slot0._onUpdateLimiterGroup, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0._onCloseViewCallBack, slot0)

	slot0._godifficultybg = gohelper.findChild(slot0.viewGO, "difficulty_bg")
	slot0._bgAnimator = gohelper.onceAddComponent(slot0._godifficultybg, gohelper.Type_Animator)
end

function slot0.onOpen(slot0)
	slot0:onInit()
end

function slot0.onUpdateParam(slot0)
	slot0:onInit()
end

function slot0.onInit(slot0)
	slot0:initDebuffs()
	slot0:initBuffEntry()
	slot0:refreshBackGroundBg()
end

function slot0.initDebuffs(slot0)
	if RougeDLCConfig101.instance:getAllVersionLimiterGroupCos(RougeModel.instance:getVersion()) then
		slot0:initBuffIcons(slot2)
		slot0:initLines(slot2)
	end

	RougeDLCModel101.instance:resetLimiterGroupNewUnlockInfo()
end

function slot0.initBuffIcons(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		slot0:_getOrCreatelimiterGroupItem(slot6.id):onUpdateMO(slot6)
	end
end

function slot0.refreshBackGroundBg(slot0)
	if slot0._riskCo == RougeDLCConfig101.instance:getRougeRiskCoByRiskValue(RougeDLCModel101.instance:getTotalRiskValue()) then
		return
	end

	slot3, slot4, slot5 = slot0:getTargetBgAnimStateInfo(slot0._riskCo, slot2)

	slot0._bgAnimator:SetFloat("speed", slot4)
	slot0._bgAnimator:Play(slot3, 0, slot5)

	if uv0[slot3] then
		AudioMgr.instance:trigger(slot6)
	end

	slot0._riskCo = slot2
end

function slot0.getTargetBgAnimStateInfo(slot0, slot1, slot2)
	slot6 = nil
	slot6 = (not RougeDLCHelper101.isLimiterRisker(slot1, slot2) and RougeDLCHelper101.isNearLimiter(slot1, slot2) or uv1.Positive) and uv1.Reverse

	return "", slot6, uv2[slot6]
end

function slot0._getOrCreatelimiterGroupItem(slot0, slot1)
	slot0._limiterGroupItemTab = slot0._limiterGroupItemTab or slot0:getUserDataTb_()

	if not slot0._limiterGroupItemTab[slot1] then
		if gohelper.isNil(gohelper.findChild(slot0.viewGO, "Left/BuffView/Viewport/Content/" .. slot1)) then
			slot4 = gohelper.create2d(gohelper.findChild(slot0.viewGO, "Left/BuffView/Viewport/Content"), slot1)

			logError("无法找到指定的限制器组挂点,已创建临时节点代替。挂点路径:" .. slot3)
		end

		slot0._limiterGroupItemTab[slot1] = MonoHelper.addNoUpdateLuaComOnceToGo(slot0:getResInst(slot0.viewContainer:getSetting().otherRes.LimiterGroupItem, slot4, "debuffitem_" .. slot1), RougeLimiterGroupItem)
	end

	return slot2
end

function slot0.initLines(slot0, slot1)
	if not slot1 then
		return
	end

	slot5 = slot1

	slot0:initUnlockMap(slot5)

	for slot5, slot6 in pairs(slot0._unlockMap) do
		for slot10, slot11 in pairs(slot6) do
			if not gohelper.isNil(gohelper.findChild(slot0.viewGO, string.format("Left/BuffView/Viewport/Content/%s_%s", slot5, slot10))) then
				gohelper.setActive(slot14, true)

				slot15 = uv0.Locked

				if RougeDLCModel101.instance:getCurLimiterGroupState(slot10) == RougeDLCEnum101.LimitState.Unlocked then
					slot15 = RougeDLCModel101.instance:isLimiterGroupNewUnlocked(slot10) and uv0.Locked2Unlocked or uv0.Unlocked
				end

				gohelper.onceAddComponent(slot14, gohelper.Type_Animator):Play(slot15, 0, 0)
			else
				logError(string.format("缺少限制器连接线:%s ---> %s", slot5, slot10))
			end
		end
	end
end

function slot0.initUnlockMap(slot0, slot1)
	slot0._unlockMap = {}

	for slot5, slot6 in ipairs(slot1) do
		slot8, slot9 = string.match(slot6.unlockCondition, "^(.*):(.+)$")

		if string.splitToNumber(slot9, "#") then
			for slot13, slot14 in ipairs(slot9) do
				slot0._unlockMap[slot14] = slot0._unlockMap[slot14] or {}
				slot0._unlockMap[slot14][slot6.id] = true
			end
		end
	end
end

function slot0.initBuffEntry(slot0)
	if not slot0._buffEntry then
		slot0._gobufficon = slot0:getResInst(slot0.viewContainer:getSetting().otherRes.LimiterItem, slot0._golimiteritem, "#go_bufficon")
		slot0._buffEntry = MonoHelper.addNoUpdateLuaComOnceToGo(slot0._gobufficon, RougeLimiterBuffEntry)
	end

	slot0._buffEntry:refreshUI(true)
end

function slot0._onUpdateLimiterGroup(slot0)
	slot0:refreshBackGroundBg()
end

function slot0._onCloseViewCallBack(slot0, slot1)
	if slot0._buffEntry then
		slot0._buffEntry:selectBuffEntry()
	end
end

function slot0.onClose(slot0)
	RougeDLCController101.instance:try2SaveLimiterSetting()
end

function slot0.onDestroyView(slot0)
end

return slot0
