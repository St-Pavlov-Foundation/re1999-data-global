-- chunkname: @modules/logic/versionactivity1_2/jiexika/model/Activity114FeaturesModel.lua

module("modules.logic.versionactivity1_2.jiexika.model.Activity114FeaturesModel", package.seeall)

local Activity114FeaturesModel = class("Activity114FeaturesModel", ListScrollModel)

function Activity114FeaturesModel:onFeatureListUpdate(featureList)
	local list = {}

	for i = 1, #featureList do
		list[i] = Activity114Config.instance:getFeatureCo(Activity114Model.instance.id, featureList[i])
	end

	self:setList(list)
end

function Activity114FeaturesModel:getAllMaxLength(txt)
	local namelist = Activity114Config.instance:getFeatureName(Activity114Model.instance.id)
	local max = 0

	for _, v in pairs(namelist) do
		local prefer = SLFramework.UGUI.GuiHelper.GetPreferredWidth(txt, v)

		max = math.max(max, prefer)
	end

	return Mathf.Clamp(max + 20, 276, 420)
end

function Activity114FeaturesModel:getFeaturePreferredLength(txt, min, max)
	local maxlength = self:getFeatureMaxLength(txt)

	return Mathf.Clamp(maxlength + 20, min, max)
end

function Activity114FeaturesModel:getFeatureMaxLength(txt)
	local list = self:getList()
	local max = 0

	for _, v in pairs(list) do
		local prefer = SLFramework.UGUI.GuiHelper.GetPreferredWidth(txt, v.features)

		max = math.max(max, prefer)
	end

	return max
end

Activity114FeaturesModel.instance = Activity114FeaturesModel.New()

return Activity114FeaturesModel
