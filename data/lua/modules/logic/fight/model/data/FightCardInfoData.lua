-- chunkname: @modules/logic/fight/model/data/FightCardInfoData.lua

module("modules.logic.fight.model.data.FightCardInfoData", package.seeall)

local FightCardInfoData = FightDataClass("FightCardInfoData")

function FightCardInfoData:onConstructor(proto)
	self:initClientData()

	self.uid = proto.uid
	self.skillId = proto.skillId
	self.cardEffect = proto.cardEffect or 0
	self.tempCard = proto.tempCard or false
	self.enchants = {}

	if proto.enchants then
		for i, v in ipairs(proto.enchants) do
			local tab = {}

			tab.enchantId = v.enchantId
			tab.duration = v.duration
			tab.exInfo = {}

			for index, value in ipairs(v.exInfo) do
				table.insert(tab.exInfo, value)
			end

			table.insert(self.enchants, tab)
		end
	end

	self.cardType = proto.cardType or FightEnum.CardType.NONE
	self.heroId = proto.heroId or 0
	self.status = proto.status or FightEnum.CardInfoStatus.STATUS_NONE
	self.targetUid = proto.targetUid or "0"
	self.energy = proto.energy or 0
	self.areaRedOrBlue = proto.areaRedOrBlue
	self.heatId = proto.heatId or 0

	if proto.musicNote then
		self.musicNote = FightRouge2MusicNote.New(proto.musicNote)
	end
end

function FightCardInfoData:initClientData()
	local clientData = FightClientData.New()

	clientData.custom_lock = nil
	clientData.custom_enemyCardIndex = nil
	clientData.custom_playedCard = nil
	clientData.custom_handCardIndex = nil
	clientData.custom_color = FightEnum.CardColor.None
	clientData.custom_fromSkillId = 0
	self.clientData = clientData
end

function FightCardInfoData:isBigSkill()
	return FightCardDataHelper.isBigSkill(self.skillId)
end

function FightCardInfoData:clone()
	return FightDataUtil.copyData(self)
end

return FightCardInfoData
