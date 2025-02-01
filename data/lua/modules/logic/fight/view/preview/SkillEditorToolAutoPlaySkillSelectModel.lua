module("modules.logic.fight.view.preview.SkillEditorToolAutoPlaySkillSelectModel", package.seeall)

slot0 = class("SkillEditorToolAutoPlaySkillSelectModel", ListScrollModel)

function slot0.selectAll(slot0)
	slot0._selectList = SkillEditorToolAutoPlaySkillModel.instance:getList()

	slot0:setList(slot0._selectList)
end

function slot0.cancelSelectAll(slot0)
	if not slot0._selectList or #slot0._selectList == 0 then
		return
	end

	for slot4, slot5 in ipairs(slot0._selectList) do
		slot0:remove(slot5)
	end

	slot0._selectList = {}
end

slot0.instance = slot0.New()

return slot0
