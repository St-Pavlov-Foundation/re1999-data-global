module("modules.live2d.Live2dSpecialLogic", package.seeall)

slot0 = class("Live2dSpecialLogic")
slot1 = {
	"pikelesi"
}

function slot0.setAlwaysFade(slot0, slot1, slot2)
	slot3 = false

	if slot2 then
		for slot7, slot8 in ipairs(uv0) do
			if string.find(slot1, slot8) then
				slot3 = true

				break
			end
		end
	end

	slot0:SetAlwaysFade(slot3)
end

slot2 = {
	{
		id = 306501,
		effect = "Drawables/bone/effect-Bone",
		frameVisible = 1
	},
	{
		id = 306502,
		effect = "Drawables/bone/effect-Bone",
		frameVisible = 1
	}
}

function slot0.getFakeUIEffect(slot0)
	for slot4, slot5 in ipairs(uv0) do
		if string.find(slot0, slot5.id) then
			return slot5, string.split(slot5.effect, "|")
		end
	end
end

return slot0
