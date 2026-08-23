#include <gtest/gtest.h>
#include "mylib.h"

TEST(AddTest, Positive) { EXPECT_EQ(add(1, 2), 3); }
TEST(AddTest, Negative) { EXPECT_EQ(add(-1, -2), -3); }
TEST(SubtractTest, Basic) { EXPECT_EQ(subtract(5, 3), 2); }
TEST(SubtractTest, NegativeResult) { EXPECT_EQ(subtract(1, 5), -4); }

// deliberately failing, to show how a gtest failure is reported
TEST(FailingTest, Deliberate) { EXPECT_EQ(add(2, 2), 5); }
