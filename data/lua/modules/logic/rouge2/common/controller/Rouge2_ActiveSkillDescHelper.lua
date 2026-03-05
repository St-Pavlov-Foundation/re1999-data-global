-- chunkname: @modules/logic/rouge2/common/controller/Rouge2_ActiveSkillDescHelper.lua

module("modules.logic.rouge2.common.controller.Rouge2_ActiveSkillDescHelper", package.seeall)

local Rouge2_ActiveSkillDescHelper = class("Rouge2_ActiveSkillDescHelper", Rouge2_ItemDescBaseHelper)

function Rouge2_ActiveSkillDescHelper:_initDefaultIncludeTypeList(includeTypeList)
	table.insert(includeTypeList, Rouge2_Enum.RelicsDescType.Desc)
	table.insert(includeTypeList, Rouge2_Enum.RelicsDescType.NarrativeDesc)
end

return Rouge2_ActiveSkillDescHelper
