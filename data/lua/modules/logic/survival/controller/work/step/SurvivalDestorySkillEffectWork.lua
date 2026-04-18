-- chunkname: @modules/logic/survival/controller/work/step/SurvivalDestorySkillEffectWork.lua

module("modules.logic.survival.controller.work.step.SurvivalDestorySkillEffectWork", package.seeall)

local SurvivalDestorySkillEffectWork = class("SurvivalDestorySkillEffectWork", SurvivalStepBaseWork)

function SurvivalDestorySkillEffectWork:onStart(context)
	local point = self._stepMo.hex[1]
	local range = self._stepMo.paramInt[1] or 0
	local scale = 1 + 0.5 * range

	AudioMgr.instance:trigger(AudioEnum2_8.Survival.play_ui_fuleyuan_tansuo_killed)
	SurvivalMapHelper.instance:addPointEffect(point, SurvivalConst.UnitEffectPath.FastFight, scale)
	self:onDone(true)
end

return SurvivalDestorySkillEffectWork
