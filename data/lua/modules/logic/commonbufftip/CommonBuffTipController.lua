module("modules.logic.commonbufftip.CommonBuffTipController", package.seeall)

slot0 = class("CommonBuffTipController")

function slot0.initViewParam(slot0)
	slot0.viewParam = slot0.viewParam or {}

	tabletool.clear(slot0.viewParam)
end

function slot0.openCommonTipView(slot0, slot1, slot2)
	slot0:initViewParam()

	slot0.viewParam.effectId = slot1
	slot0.viewParam.clickPosition = slot2

	ViewMgr.instance:openView(ViewName.CommonBuffTipView, slot0.viewParam)
end

function slot0.openCommonTipViewWithCustomPos(slot0, slot1, slot2, slot3)
	slot0:initViewParam()

	slot0.viewParam.effectId = slot1
	slot0.viewParam.scrollAnchorPos = slot2
	slot0.viewParam.pivot = slot3 or CommonBuffTipEnum.Pivot.Left

	ViewMgr.instance:openView(ViewName.CommonBuffTipView, slot0.viewParam)
end

function slot0.openCommonTipViewWithCustomPosCallback(slot0, slot1, slot2, slot3)
	slot0:initViewParam()

	slot0.viewParam.effectId = slot1
	slot0.viewParam.setScrollPosCallback = slot2
	slot0.viewParam.setScrollPosCallbackObj = slot3

	ViewMgr.instance:openView(ViewName.CommonBuffTipView, slot0.viewParam)
end

function slot0.getBuffTagName(slot0, slot1)
	if tonumber(string.match(slot1, "<id:(%d+)>")) then
		return slot0:getBuffTagNameByBuffId(slot2, slot1)
	end

	return slot0:getBuffTagNameByBuffName(slot1)
end

function slot0.getBuffTagNameByBuffId(slot0, slot1, slot2)
	if slot1 and lua_skill_buff.configDict[slot1] and slot3.name == SkillHelper.removeRichTag(slot2) then
		return slot0:getBuffTagNameByTypeId(slot3.typeId)
	end

	return slot0:getBuffTagNameByBuffName(slot2)
end

function slot0.getBuffTagNameByBuffName(slot0, slot1)
	if string.nilorempty(SkillHelper.removeRichTag(slot1)) then
		return ""
	end

	for slot5, slot6 in ipairs(lua_skill_buff.configList) do
		if slot6.name == slot1 then
			return slot0:getBuffTagNameByTypeId(slot6.typeId)
		end
	end

	return ""
end

function slot0.getBuffTagNameByTypeId(slot0, slot1)
	slot2 = slot1 and lua_skill_bufftype.configDict[slot1]

	if slot2 and lua_skill_buff_desc.configDict[slot2.type] and slot3.id ~= 9 then
		return slot3.name
	end

	return ""
end

slot0.instance = slot0.New()

return slot0
