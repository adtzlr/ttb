module test_suite1
   use testdrive, only: new_unittest, unittest_type, error_type, check, test_failed
   use, intrinsic :: iso_fortran_env, only: error_unit
   implicit none
   private

   public :: collect_suite1

contains

!> Collect all exported unit tests
   subroutine collect_suite1(testsuite)
      !> Collection of tests
      type(unittest_type), allocatable, intent(out) :: testsuite(:)
      integer, parameter :: ntests = 2

      allocate (testsuite(ntests))
      testsuite(1) = new_unittest("valid", test_valid)
      testsuite(2) = new_unittest("invalid", test_invalid, should_fail=.true.)

   end subroutine collect_suite1

   subroutine test_valid(error)
      type(error_type), allocatable, intent(out) :: error

      call check(error, 1 + 2 == 3)
      if (allocated(error)) return

   end subroutine test_valid

   subroutine test_invalid(error)
      type(error_type), allocatable, intent(out) :: error
      integer :: i = 1
      ! ...

      if (i .eq. 1) then
         call test_failed(error, "Custom check failed")
         return
      end if
   end subroutine test_invalid

end module test_suite1
