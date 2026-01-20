-- chunkname: @modules/logic/rouge2/common/controller/Rouge2_ViewHelper.lua

module("modules.logic.rouge2.common.controller.Rouge2_ViewHelper", package.seeall)

local Rouge2_ViewHelper = class("Rouge2_ViewHelper")

function Rouge2_ViewHelper.openDifficultySelectView(params)
	ViewMgr.instance:openView(ViewName.Rouge2_DifficultySelectView, params)
end

function Rouge2_ViewHelper.openCareerSelectView(params)
	ViewMgr.instance:openView(ViewName.Rouge2_CareerSelectView, params)
end

function Rouge2_ViewHelper.openCareerSkillTipsView(dataType, dataId, tipPos, usage, extraParams)
	local params = {
		dataType = dataType,
		dataId = dataId,
		tipPos = tipPos,
		usage = usage,
		extraParams = extraParams
	}

	ViewMgr.instance:openView(ViewName.Rouge2_CareerSkillTipsView, params)
end

function Rouge2_ViewHelper.openCareerAttributeTipsView(careerId, attributeId, attributeValue, pos, offset, clickCallback, clickCallbackObj)
	local params = {
		careerId = careerId,
		attributeId = attributeId,
		attributeValue = attributeValue,
		pos = pos,
		offset = offset,
		clickCallback = clickCallback,
		clickCallbackObj = clickCallbackObj
	}

	ViewMgr.instance:openView(ViewName.Rouge2_CareerAttributeTipsView, params)
end

function Rouge2_ViewHelper.openBackpackSkillEditView(selectSkillIndex)
	selectSkillIndex = selectSkillIndex or 1

	local params = {
		selectIndex = selectSkillIndex
	}

	ViewMgr.instance:openView(ViewName.Rouge2_BackpackSkillEditView, params)
end

function Rouge2_ViewHelper.openMainView(params)
	ViewMgr.instance:openView(ViewName.Rouge2_MainView, params)
end

function Rouge2_ViewHelper.openEnterView(params)
	ViewMgr.instance:openView(ViewName.Rouge2_EnterView, params)
end

function Rouge2_ViewHelper.openStoreView(params)
	ViewMgr.instance:openView(ViewName.Rouge2_StoreView, params)
end

function Rouge2_ViewHelper.openBackpackTabView(tabId, extraParams)
	local params = {
		defaultTabIds = {
			[Rouge2_Enum.BackpackTabContainerId] = tabId
		},
		extraParams = extraParams
	}

	ViewMgr.instance:openView(ViewName.Rouge2_BackpackTabView, params)
end

function Rouge2_ViewHelper.openAttributeDetailView(careerId, attrInfoList)
	careerId = careerId or Rouge2_Model.instance:getCareerId()
	attrInfoList = attrInfoList or Rouge2_Model.instance:getHeroAttrInfoList()

	local params = {
		careerId = careerId,
		attrInfoList = attrInfoList
	}

	ViewMgr.instance:openView(ViewName.Rouge2_AttributeDetailView, params)
end

function Rouge2_ViewHelper.openTalentTreeView(params)
	ViewMgr.instance:openView(ViewName.Rouge2_TalentTreeView, params)
end

function Rouge2_ViewHelper.openTalentTreeOverView(params)
	ViewMgr.instance:openView(ViewName.Rouge2_TalentTreeOverView, params)
end

function Rouge2_ViewHelper.openIllustrationMainView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.Rouge2_IllustrationMainView, param, isImmediate)
end

function Rouge2_ViewHelper.openRougeIllustrationDetailView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.Rouge2_IllustrationDetailView, param, isImmediate)
end

function Rouge2_ViewHelper.openRougeCareerHandBookView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.Rouge2_CareerHandBookMainView, param, isImmediate)
end

function Rouge2_ViewHelper.openRougeCareerHandBookDetailView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.Rouge2_CareerHandBookDetailView, param, isImmediate)
end

function Rouge2_ViewHelper.openRouge2UnlockInfoView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.Rouge2_ResultUnlockInfoView, param, isImmediate)
end

return Rouge2_ViewHelper
