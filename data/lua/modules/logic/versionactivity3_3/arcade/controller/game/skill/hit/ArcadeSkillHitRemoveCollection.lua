-- chunkname: @modules/logic/versionactivity3_3/arcade/controller/game/skill/hit/ArcadeSkillHitRemoveCollection.lua

module("modules.logic.versionactivity3_3.arcade.controller.game.skill.hit.ArcadeSkillHitRemoveCollection", package.seeall)

local ArcadeSkillHitRemoveCollection = class("ArcadeSkillHitRemoveCollection", ArcadeSkillHitBase)

function ArcadeSkillHitRemoveCollection:onCtor()
	local params = self._params

	self._changeName = params[1]

	local collIdStr = params[2]

	self._collectionUidList = {}

	if string.nilorempty(collIdStr) then
		self._collectionIdList = {}
	else
		self._collectionIdList = string.splitToNumber(collIdStr, ",")
	end
end

function ArcadeSkillHitRemoveCollection:onHit()
	local characterMO = ArcadeGameModel.instance:getCharacterMO()

	self:clearList(self._collectionUidList)

	for _, collectionId in ipairs(self._collectionIdList) do
		local uidList = characterMO:getCollectionId2Uids(collectionId)

		if uidList and #uidList > 0 then
			local uid = uidList[1]

			characterMO:removeCollection(uid)
			table.insert(self._collectionUidList, uid)
		end
	end

	if #self._collectionUidList > 0 then
		ArcadeGameController.instance:dispatchEvent(ArcadeEvent.OnCollectionChange)
	end
end

function ArcadeSkillHitRemoveCollection:onHitPrintLog()
	if #self._collectionUidList > 0 then
		logNormal(string.format("%s ==> 移除特定Id藏品。uIds:%s ", self:getLogPrefixStr(), table.concat(self._collectionUidList, ",")))
	end
end

return ArcadeSkillHitRemoveCollection
