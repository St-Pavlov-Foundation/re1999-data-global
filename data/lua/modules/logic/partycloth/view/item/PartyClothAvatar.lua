-- chunkname: @modules/logic/partycloth/view/item/PartyClothAvatar.lua

module("modules.logic.partycloth.view.item.PartyClothAvatar", package.seeall)

local PartyClothAvatar = class("PartyClothAvatar", LuaCompBase)

function PartyClothAvatar:init(go)
	self.go = go

	gohelper.setLayer(go, UnityLayer.Scene, true)

	self._resLoader = SpinePrefabInstantiate.Create(go)
	self._resPath = PartyGameEnum.PartyGameSceneSpineRes

	self._resLoader:startLoad(self._resPath, self._resPath, self._onResLoaded, self)
end

function PartyClothAvatar:_onResLoaded()
	self._spineGo = self._resLoader:getInstGO()

	local spineComp = self._spineGo:AddComponent(typeof(PartyGame.Runtime.Spine.PartyGameLobbySceneSpine))

	self._spineComp = spineComp

	if self._skinResMap then
		self:refreshSkin(self._skinResMap)

		self._skinResMap = nil
	end
end

function PartyClothAvatar:onDestroy()
	if self._resLoader then
		self._resLoader:dispose()
	end
end

function PartyClothAvatar:refreshSkin(resMap)
	if self._spineComp then
		local body = resMap[PartyClothEnum.ClothType.Body] or ""
		local head = resMap[PartyClothEnum.ClothType.Head] or ""
		local pant = resMap[PartyClothEnum.ClothType.Pant] or ""
		local shoes = resMap[PartyClothEnum.ClothType.Shoes] or ""
		local hat = resMap[PartyClothEnum.ClothType.Hat] or ""
		local jacket = resMap[PartyClothEnum.ClothType.Jacket] or ""

		self._spineComp:SetSkins(body, head, pant, shoes, hat, jacket)
	else
		self._skinResMap = resMap
	end
end

return PartyClothAvatar
