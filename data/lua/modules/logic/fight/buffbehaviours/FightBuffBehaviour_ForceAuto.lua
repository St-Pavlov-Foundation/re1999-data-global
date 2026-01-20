-- chunkname: @modules/logic/fight/buffbehaviours/FightBuffBehaviour_ForceAuto.lua

module("modules.logic.fight.buffbehaviours.FightBuffBehaviour_ForceAuto", package.seeall)

local FightBuffBehaviour_ForceAuto = class("FightBuffBehaviour_ForceAuto", FightBuffBehaviourBase)
local autoBtnPath = "ui/viewres/fight/fighttower/fightautobtnlockview.prefab"
local SiblingIndex = 3

function FightBuffBehaviour_ForceAuto:onAddBuff(entityId, buffId, buffMo)
	self.btnRoot = gohelper.findChild(self.viewGo, "root/btns")
	self.srcAutoBtn = gohelper.findChild(self.viewGo, "root/btns/btnAuto")
	self.loader = PrefabInstantiate.Create(self.btnRoot)

	self.loader:startLoad(autoBtnPath, self.onLoadFinish, self)
	FightDataHelper.stateMgr:setBuffForceAuto(true)
	FightGameMgr.operateMgr:requestAutoFight()
	AudioMgr.instance:trigger(310004)
end

function FightBuffBehaviour_ForceAuto:onLoadFinish()
	self.autoBtn = self.loader:getInstGO()

	gohelper.setSibling(self.autoBtn, SiblingIndex)
	gohelper.setActive(self.srcAutoBtn, false)
	gohelper.setActive(self.autoBtn, true)
end

function FightBuffBehaviour_ForceAuto:onUpdateBuff(entityId, buffId, buffMo)
	return
end

function FightBuffBehaviour_ForceAuto:onRemoveBuff(entityId, buffId, buffMo)
	gohelper.destroy(self.autoBtn)
	gohelper.setActive(self.srcAutoBtn, true)
	FightDataHelper.stateMgr:setBuffForceAuto(false)
end

function FightBuffBehaviour_ForceAuto:onDestroy()
	if self.loader then
		self.loader:dispose()

		self.loader = nil
	end

	FightDataHelper.stateMgr:setBuffForceAuto(false)
	FightBuffBehaviour_ForceAuto.super.onDestroy(self)
end

return FightBuffBehaviour_ForceAuto
