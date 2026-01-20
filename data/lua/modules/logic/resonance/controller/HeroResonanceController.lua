-- chunkname: @modules/logic/resonance/controller/HeroResonanceController.lua

module("modules.logic.resonance.controller.HeroResonanceController", package.seeall)

local HeroResonanceController = class("HeroResonanceController", BaseController)

function HeroResonanceController:ctor()
	return
end

function HeroResonanceController:statShareCode(heroMo, isUse, code)
	local stateGroupList = {}

	if heroMo and heroMo.talentCubeInfos and heroMo.talentCubeInfos.data_list then
		for _, data in ipairs(heroMo.talentCubeInfos.data_list) do
			local cubeId = data.cubeId
			local mainCubeId = heroMo.talentCubeInfos.own_main_cube_id

			if data.cubeId == mainCubeId then
				cubeId = heroMo:getHeroUseStyleCubeId()
			end

			table.insert(stateGroupList, cubeId)
		end
	end

	code = code or HeroResonaceModel.instance:getShareCode() or ""

	local eventName = isUse and StatEnum.EventName.TalentUseRuenCode or StatEnum.EventName.TalentCopyRuenCode

	StatController.instance:track(eventName, {
		[StatEnum.EventProperties.TalentShareCode] = code,
		[StatEnum.EventProperties.HeroId] = heroMo.heroId,
		[StatEnum.EventProperties.HeroName] = heroMo.config.name,
		[StatEnum.EventProperties.TalentRuensStateGroup] = stateGroupList
	})
end

HeroResonanceController.instance = HeroResonanceController.New()

return HeroResonanceController
