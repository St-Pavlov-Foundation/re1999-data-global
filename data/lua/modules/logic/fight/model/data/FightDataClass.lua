module("modules.logic.fight.model.data.FightDataClass", package.seeall)

slot0 = {}
slot1 = {
	ctor = function ()
	end,
	onConstructor = function ()
	end
}
slot2 = {}
slot3 = {}

function slot4(slot0, slot1, ...)
	if uv0[slot0.__cname] then
		uv1(slot2, slot1, ...)
	end

	if rawget(slot0, "onConstructor") then
		return slot3(slot1, ...)
	end
end

setmetatable(slot0, {
	__call = function (slot0, slot1, slot2)
		if slot2 then
			setmetatable({
				__cname = slot1
			}, {
				__index = slot2
			})
		else
			setmetatable(slot3, {
				__index = uv0
			})
		end

		uv1[slot1] = {
			__index = slot3
		}
		uv2[slot1] = slot2

		function slot3.New(...)
			slot0 = {
				__cname = uv0
			}

			setmetatable(slot0, uv1[uv0])
			slot0:ctor()
			uv2(uv3, slot0, ...)

			return slot0
		end

		return slot3
	end
})

return slot0
