slot0 = string.format

module("modules.logic.activity.model.ActivityType101Model", package.seeall)

slot1 = class("ActivityType101Model", BaseModel)
slot2 = 0
slot3 = 1
slot4 = 2

function slot1.onInit(slot0)
	slot0:reInit()
end

function slot1.reInit(slot0)
	slot0._type101Info = {}

	slot0:setCurIndex(nil)
end

function slot1.setType101Info(slot0, slot1)
	slot2 = {}
	slot3 = {
		[slot9.id] = slot10
	}
	slot4 = {}

	for slot8, slot9 in ipairs(slot1.infos) do
		ActivityType101InfoMo.New():init(slot9)
	end

	for slot8, slot9 in ipairs(slot1.spInfos) do
		slot11 = ActivityType101SpInfoMo.New()

		slot11:init(slot9)

		slot4[slot9.id] = slot11
	end

	slot2.infos = slot3
	slot2.count = slot1.loginCount
	slot2.spInfos = slot4
	slot0._type101Info[slot1.activityId] = slot2
end

function slot1.setBonusGet(slot0, slot1)
	if not slot0:isInit(slot1.activityId) then
		return
	end

	slot0._type101Info[slot2].infos[slot1.id].state = uv0
end

function slot1.getType101LoginCount(slot0, slot1)
	if not slot0:isInit(slot1) then
		return 0
	end

	return slot0._type101Info[slot1].count
end

function slot1.isType101RewardGet(slot0, slot1, slot2)
	return slot0:getType101InfoState(slot1, slot2) == uv0
end

function slot1.isType101RewardCouldGet(slot0, slot1, slot2)
	return slot0:getType101InfoState(slot1, slot2) == uv0
end

function slot1.getType101Info(slot0, slot1)
	if not slot0:isInit(slot1) then
		return
	end

	return slot0._type101Info[slot1].infos
end

function slot1.getCurIndex(slot0)
	return slot0._curIndex
end

function slot1.setCurIndex(slot0, slot1)
	slot0._curIndex = slot1
end

function slot1.isType101RewardCouldGetAnyOne(slot0, slot1)
	if not slot0:getType101Info(slot1) then
		return false
	end

	for slot6, slot7 in pairs(slot2) do
		if slot7.state == uv0 then
			return true
		end
	end

	return false
end

function slot1.hasReceiveAllReward(slot0, slot1)
	if not slot0:getType101Info(slot1) then
		return true
	end

	for slot6, slot7 in pairs(slot2) do
		if slot7.state == uv0 or slot7.state == uv1 then
			return false
		end
	end

	return true
end

function slot1.isInit(slot0, slot1)
	return slot0._type101Info[slot1] and true or false
end

function slot1.isOpen(slot0, slot1)
	return ActivityHelper.getActivityStatus(slot1, true) == ActivityEnum.ActivityStatus.Normal
end

function slot1.getLastGetIndex(slot0, slot1)
	if uv0.instance:getType101LoginCount(slot1) == 0 then
		return 0
	end

	if slot0:isType101RewardGet(slot2) then
		return slot2
	end

	if not slot0:getType101Info(slot1) then
		return 0
	end

	slot5 = {}

	for slot9, slot10 in pairs(slot4) do
		if slot10.state == uv1 then
			slot5[#slot5 + 1] = slot10.id
		end
	end

	table.sort(slot5)

	return slot5[#slot5] or 0
end

function slot1.getType101InfoState(slot0, slot1, slot2)
	if not slot0:isInit(slot1) then
		return uv0
	end

	if not slot0:getType101Info(slot1) then
		return uv0
	end

	if not slot3[slot2] then
		return uv0
	end

	return slot4.state or uv0
end

function slot1.getType101SpInfo(slot0, slot1)
	if not slot0:isInit(slot1) then
		return
	end

	return slot0._type101Info[slot1].spInfos
end

function slot1.getType101SpInfoMo(slot0, slot1, slot2)
	if not slot0:isInit(slot1) then
		return
	end

	if not slot0:getType101SpInfo(slot1) then
		return
	end

	return slot3[slot2]
end

function slot1.isType101SpRewardUncompleted(slot0, slot1, slot2)
	if not slot0:getType101SpInfoMo(slot1, slot2) then
		return false
	end

	return slot3:isNone()
end

function slot1.isType101SpRewardCouldGet(slot0, slot1, slot2)
	if not slot0:getType101SpInfoMo(slot1, slot2) then
		return false
	end

	return slot3:isAvailable()
end

function slot1.isType101SpRewardGot(slot0, slot1, slot2)
	if not slot0:getType101SpInfoMo(slot1, slot2) then
		return false
	end

	return slot3:isReceived()
end

function slot1.setSpBonusGet(slot0, slot1)
	if not slot0:getType101SpInfoMo(slot1.activityId, slot1.id) then
		return
	end

	slot4:setState_Received()
end

function slot1.isType101SpRewardCouldGetAnyOne(slot0, slot1)
	if not slot0:getType101SpInfo(slot1) then
		return false
	end

	for slot6, slot7 in pairs(slot2) do
		if slot7:isAvailable() then
			return true
		end
	end

	return false
end

function slot1.claimAll(slot0, slot1, slot2, slot3)
	if uv0.instance:getType101LoginCount(slot1) == 0 then
		if slot2 then
			slot2(slot3)
		end

		return
	end

	if not slot0:getType101Info(slot1) then
		if slot2 then
			slot2(slot3)
		end

		return
	end

	slot6 = {}

	for slot10, slot11 in pairs(slot5) do
		if slot11.state == uv1 then
			slot6[#slot6 + 1] = slot11.id
		end
	end

	for slot10, slot11 in ipairs(slot6) do
		slot12, slot13 = nil

		if slot10 == #slot6 then
			slot12 = slot2
			slot13 = slot3
		end

		Activity101Rpc.instance:sendGet101BonusRequest(slot1, slot11, slot12, slot13)
	end
end

slot5 = "_Container"
slot6 = {
	bgBlur = 0,
	destroy = 0,
	mainRes = "ui/viewres/activity/v%sa%s_role_fullsignview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1.0] = "ui/viewres/activity/v%sa%s_role_signitem.prefab"
	}
}
slot7 = slot6
slot8 = tabletool.copy(slot6)
slot7.container = "Vxax_Role_FullSignView_Part1_Container"
slot8.container = "Vxax_Role_FullSignView_Part2_Container"
slot7._viewName = "V%sa%s_Role_FullSignView_Part1"
slot8._viewName = "V%sa%s_Role_FullSignView_Part2"
slot7._viewContainerName = slot7._viewName .. slot5
slot8._viewContainerName = slot8._viewName .. slot5
slot7._isFullView = true
slot8._isFullView = true
slot7._whichPart = 1
slot8._whichPart = 2
slot9 = {
	bgBlur = 1,
	destroy = 0,
	mainRes = "ui/viewres/activity/v%sa%s_role_panelsignview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1.0] = "ui/viewres/activity/v%sa%s_role_signitem.prefab"
	}
}
slot10 = slot9
slot11 = tabletool.copy(slot9)
slot10.container = "Vxax_Role_PanelSignView_Part1_Container"
slot11.container = "Vxax_Role_PanelSignView_Part2_Container"
slot10._viewName = "V%sa%s_Role_PanelSignView_Part1"
slot11._viewName = "V%sa%s_Role_PanelSignView_Part2"
slot10._viewContainerName = slot10._viewName .. slot5
slot11._viewContainerName = slot11._viewName .. slot5
slot10._isFullView = false
slot11._isFullView = false
slot10._whichPart = 1
slot11._whichPart = 2
slot12 = {
	bgBlur = 0,
	container = "Vxax_Special_FullSignViewContainer",
	destroy = 0,
	_viewContainerName = "V%sa%s_Special_FullSignViewContainer",
	_isFullView = true,
	_viewName = "V%sa%s_Special_FullSignView",
	mainRes = "ui/viewres/activity/v%sa%s_special_fullsignview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
slot13 = {
	bgBlur = 1,
	container = "Vxax_Special_PanelSignViewContainer",
	destroy = 0,
	_viewContainerName = "V%sa%s_Special_PanelSignViewContainer",
	_isFullView = false,
	_viewName = "V%sa%s_Special_PanelSignView",
	mainRes = "ui/viewres/activity/v%sa%s_special_panelsignview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
slot14 = {
	bgBlur = 0,
	container = "Vxax_LinkageActivity_FullViewContainer",
	destroy = 0,
	_viewContainerName = "V%sa%s_LinkageActivity_FullViewContainer",
	_isFullView = true,
	_viewName = "V%sa%s_LinkageActivity_FullView",
	mainRes = "ui/viewres/activity/v%sa%s_linkageactivity_fullview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
slot15 = {
	bgBlur = 1,
	container = "Vxax_LinkageActivity_PanelViewContainer",
	destroy = 0,
	_viewContainerName = "V%sa%s_LinkageActivity_PanelViewContainer",
	_isFullView = false,
	_viewName = "V%sa%s_LinkageActivity_PanelView",
	mainRes = "ui/viewres/activity/v%sa%s_linkageactivity_panelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}

function slot16(slot0, slot1, slot2)
	function slot3(slot0)
		slot0.mainRes = uv0(slot0.mainRes, uv1, uv2)
		slot0.otherRes[1] = uv0(slot0.otherRes[1], uv1, uv2)
		slot0._viewName = uv0(slot0._viewName, uv1, uv2)
		slot3 = nil
		slot4 = _G.class(uv0(slot0._viewContainerName, uv1, uv2), Vxax_Role_SignItem_SignViewContainer)

		if slot0._isFullView then
			Vxax_Role_SignItem_SignViewContainer.Vxax_Role_FullSignView_PartX(_G.class(slot1, Vxax_Role_FullSignView), uv1, uv2, slot0._whichPart)
		else
			Vxax_Role_SignItem_SignViewContainer.Vxax_Role_PanelSignView_PartX(_G.class(slot1, Vxax_Role_PanelSignView), uv1, uv2, slot0._whichPart)
		end

		Vxax_Role_SignItem_SignViewContainer.Vxax_Role_xxxSignView_Container(slot4, slot3)

		uv3[slot1] = slot0

		rawset(_G.ViewName, slot1, slot1)
		rawset(_G, slot1, slot3)
		rawset(_G, slot2, slot4)
	end

	slot3(uv1)
	slot3(uv2)
	slot3(uv3)
	slot3(uv4)
end

function slot17(slot0, slot1, slot2)
	function slot3(slot0)
		slot0.mainRes = uv0(slot0.mainRes, uv1, uv2)
		slot0._viewName = uv0(slot0._viewName, uv1, uv2)
		slot3 = nil
		slot4 = _G.class(uv0(slot0._viewContainerName, uv1, uv2), Vxax_Special_SignItemViewContainer)

		if slot0._isFullView then
			Vxax_Special_SignItemViewContainer.Vxax_Special_FullSignView(_G.class(slot1, uv3), uv1, uv2)
		else
			Vxax_Special_SignItemViewContainer.Vxax_Special_PanelSignView(_G.class(slot1, uv4), uv1, uv2)
		end

		Vxax_Special_SignItemViewContainer.Vxax_Special_xxxSignView_Container(slot4, slot3)

		uv5[slot1] = slot0

		rawset(_G.ViewName, slot1, slot1)
		rawset(_G, slot1, slot3)
		rawset(_G, slot2, slot4)
	end

	slot3(uv1)
	slot3(uv2)
end

function slot18(slot0, slot1, slot2)
	function slot3(slot0)
		slot0.mainRes = uv0(slot0.mainRes, uv1, uv2)
		slot0._viewName = uv0(slot0._viewName, uv1, uv2)
		slot3 = nil
		slot4 = _G.class(uv0(slot0._viewContainerName, uv1, uv2), LinkageActivity_BaseViewContainer)

		if slot0._isFullView then
			LinkageActivity_BaseViewContainer.Vxax_LinkageActivity_FullView(_G.class(slot1, LinkageActivity_FullView), uv1, uv2)
		else
			LinkageActivity_BaseViewContainer.Vxax_LinkageActivity_PanelView(_G.class(slot1, LinkageActivity_PanelView), uv1, uv2)
		end

		LinkageActivity_BaseViewContainer.Vxax_LinkageActivity_xxxView_Container(slot4, slot3)

		uv3[slot1] = slot0

		rawset(_G.ViewName, slot1, slot1)
		rawset(_G, slot1, slot3)
		rawset(_G, slot2, slot4)
	end

	slot3(uv1)
	slot3(uv2)
end

function slot1.onModuleViews(slot0, slot1, slot2)
	slot3 = slot1.curV
	slot4 = slot1.curA

	uv0(2, 7, slot2)
end

slot1.instance = slot1.New()

return slot1
