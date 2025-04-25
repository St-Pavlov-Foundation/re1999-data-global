module("modules.common.utils.Bitwise", package.seeall)

slot0 = require("bit")

return {
	["&"] = function (slot0, slot1)
		return uv0.band(slot0, slot1)
	end,
	["|"] = function (slot0, slot1)
		return uv0.bor(slot0, slot1)
	end,
	[">>"] = function (slot0, slot1)
		return uv0.rshift(slot0, slot1)
	end,
	["<<"] = function (slot0, slot1)
		return uv0.lshift(slot0, slot1)
	end,
	["^"] = function (slot0, slot1)
		return uv0.bxor(slot0, slot1)
	end,
	["~"] = function (slot0)
		return uv0.bnot(slot0)
	end,
	hasAny = function (slot0, slot1)
		return uv0["&"](slot0, slot1) ~= 0
	end,
	has = function (slot0, slot1)
		return uv0["&"](slot0, slot1) == slot1
	end,
	set = function (slot0, slot1)
		return uv0["|"](slot0, slot1)
	end,
	unset = function (slot0, slot1)
		return uv0["&"](slot0, uv0["~"](slot1))
	end,
	lowbit = function (slot0)
		return uv0["&"](slot0, -slot0)
	end,
	isPow2 = function (slot0)
		if slot0 == 0 then
			return true
		end

		return uv0["&"](slot0, slot0 - 1) == 0
	end,
	nextPow2 = function (slot0)
		slot0 = slot0 - 1
		slot0 = uv0["|"](slot0, uv0[">>"](slot0, 1))
		slot0 = uv0["|"](slot0, uv0[">>"](slot0, 2))
		slot0 = uv0["|"](slot0, uv0[">>"](slot0, 4))
		slot0 = uv0["|"](slot0, uv0[">>"](slot0, 8))
		slot0 = uv0["|"](slot0, uv0[">>"](slot0, 16))

		return uv0["|"](slot0, uv0[">>"](slot0, 32)) + 1
	end,
	count1 = function (slot0)
		slot1 = 0

		while slot0 ~= 0 do
			slot0 = slot0 - uv0.lowbit(slot0)
			slot1 = slot1 + 1
		end

		return slot1
	end,
	unitTest = function ()
		assert(uv0["&"](2, 3) == 2)
		assert(uv0["|"](1, 2) == 3)
		assert(uv0[">>"](2, 1) == 1)
		assert(uv0["<<"](2, 1) == 4)
		assert(uv0["^"](1, 3) == 2)
		assert(uv0["~"](1) == -2)
		assert(uv0["~"](4) == -5)
		assert(uv1.hasAny(5, 1) == true)
		assert(uv1.hasAny(5, 2) == false)
		assert(uv1.hasAny(5, 3) == true)
		assert(uv1.has(5, 3) == false)
		assert(uv1.has(6, 3) == false)
		assert(uv1.has(6, 4) == true)
		assert(uv1.set(5, 1) == 5)
		assert(uv1.unset(5, 1) == 4)
		assert(uv1.unset(5, 3) == 4)
		assert(uv1.lowbit(5) == 1)
		assert(uv1.lowbit(4) == 4)
		assert(uv1.isPow2(0) == true)
		assert(uv1.isPow2(4) == true)
		assert(uv1.isPow2(64) == true)
		assert(uv1.isPow2(5) == false)
		assert(uv1.nextPow2(8) == 8)
		assert(uv1.nextPow2(16) == 16)
		assert(uv1.nextPow2(17) == 32)
		assert(uv1.nextPow2(1) == 1)
		assert(uv1.nextPow2(0) == 0)
		assert(uv1.nextPow2(320) == 512)
		assert(uv1.count1(5) == 2)
		assert(uv1.count1(15) == 4)
		assert(uv1.count1(128) == 1)
		assert(uv1.count1(127) == 7)
	end
}
