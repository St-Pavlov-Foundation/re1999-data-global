-- chunkname: @modules/logic/fight/view/preview/SkillEditorToolAutoPlaySkillSelectModel.lua

module("modules.logic.fight.view.preview.SkillEditorToolAutoPlaySkillSelectModel", package.seeall)

local SkillEditorToolAutoPlaySkillSelectModel = class("SkillEditorToolAutoPlaySkillSelectModel", ListScrollModel)

function SkillEditorToolAutoPlaySkillSelectModel:selectAll()
	local list = SkillEditorToolAutoPlaySkillModel.instance:getList()

	self._selectList = list

	self:setList(self._selectList)
end

function SkillEditorToolAutoPlaySkillSelectModel:cancelSelectAll()
	if not self._selectList or #self._selectList == 0 then
		return
	end

	for index, mo in ipairs(self._selectList) do
		self:remove(mo)
	end

	self._selectList = {}
end

SkillEditorToolAutoPlaySkillSelectModel.instance = SkillEditorToolAutoPlaySkillSelectModel.New()

return SkillEditorToolAutoPlaySkillSelectModel
