-- chunkname: @modules/logic/rouge2/map/view/fightsucc/Rouge2_FightSuccessHeroItem.lua

module("modules.logic.rouge2.map.view.fightsucc.Rouge2_FightSuccessHeroItem", package.seeall)

local Rouge2_FightSuccessHeroItem = class("Rouge2_FightSuccessHeroItem", LuaCompBase)

function Rouge2_FightSuccessHeroItem:init(go)
	self.go = go
	self.slider = gohelper.findChildSlider(go, "#slider_hp")
	self.simageRole = gohelper.findChildSingleImage(go, "hero/#simage_rolehead")
	self.goDead = gohelper.findChild(go, "#go_dead")
end

function Rouge2_FightSuccessHeroItem:refreshHero(heroMo)
	local heroId = heroMo and heroMo.heroId

	if heroId ~= 0 then
		gohelper.setActive(self.go, true)

		local headIcon = self:getHeroHeadIcon(heroId)

		self.simageRole:LoadImage(ResUrl.getRoomHeadIcon(headIcon))

		local fightResultInfo = Rouge2_Model.instance:getFightResultInfo()
		local life = fightResultInfo and fightResultInfo:getLife(heroId)

		if life <= 0 then
			self.slider:SetValue(0)
			gohelper.setActive(self.goDead, true)
		else
			self.slider:SetValue(life / 1000)
			gohelper.setActive(self.goDead, false)
		end
	end
end

function Rouge2_FightSuccessHeroItem:getHeroHeadIcon(heroId)
	local teamInfo = Rouge2_Model.instance:getTeamInfo()
	local isAssist = teamInfo and teamInfo:isAssistHero(heroId)
	local heroMo

	if isAssist then
		heroMo = teamInfo:getAssistHeroMo()
	else
		heroMo = HeroModel.instance:getByHeroId(heroId)
	end

	local skinId = heroMo and heroMo.skin
	local skinCo = skinId and lua_skin.configDict[skinId]

	return skinCo and skinCo.headIcon or heroId .. "01"
end

function Rouge2_FightSuccessHeroItem:onDestroyView()
	self.simageRole:UnLoadImage()
end

return Rouge2_FightSuccessHeroItem
