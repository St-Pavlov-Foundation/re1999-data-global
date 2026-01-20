-- chunkname: @modules/logic/fight/view/rouge2/FightRouge2TechniqueViewGuidOverseasImpl.lua

module("modules.logic.fight.view.rouge2.FightRouge2TechniqueViewGuidOverseasImpl", package.seeall)

local FightRouge2TechniqueViewGuidOverseasImpl = class("FightRouge2TechniqueViewGuidOverseasImpl", RougeSimpleItemBase)

function FightRouge2TechniqueViewGuidOverseasImpl:ctor(ctorParam)
	self:__onInit()
	FightRouge2TechniqueViewGuidOverseasImpl.super.ctor(self, ctorParam)
end

function FightRouge2TechniqueViewGuidOverseasImpl:onDestroyView()
	FightRouge2TechniqueViewGuidOverseasImpl.super.onDestroyView(self)
	self:__onDispose()
end

function FightRouge2TechniqueViewGuidOverseasImpl:_editableInitView()
	FightRouge2TechniqueViewGuidOverseasImpl.super._editableInitView(self)

	local cn = self:childCount()
	local trans = self:transform()

	self._childTxts = self:getUserDataTb_()

	for i = 0, cn - 1 do
		local childTrans = trans:GetChild(i)
		local txtComp = childTrans:GetComponent(gohelper.Type_TextMesh)

		if txtComp then
			table.insert(self._childTxts, txtComp)
		end
	end
end

function FightRouge2TechniqueViewGuidOverseasImpl:setText(index, text)
	local txtComp = self._childTxts[index]

	if txtComp then
		txtComp.text = text
	end
end

return FightRouge2TechniqueViewGuidOverseasImpl
