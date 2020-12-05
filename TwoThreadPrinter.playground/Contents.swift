import UIKit

/**
 This can be done using a Lock or a Semaphore.
 Lock: an abstract concept for threads synchronization. The main idea is to
 protect access to a given region of code at a time. Different kinds of locks exist.
 Semaphores are special kinds of locks that allow up to N threads to access a
 given region of code at a time.
 Mutex ensures that only one thread is active in a given region of code at a time. Essentially,
 a mutex is a semaphore with a maximum thread count of 1.

 What is a counting semaphore?
 A counting semaphore contains a value and supports two operations "wait" and "post".
 Post increments the semaphore and immediately returns. "wait" will wait if the count is zero.
 If the count is non-zero the semaphore decrements the count and immediately returns.

An analogy is a count of the cookies in a cookie jar (or gold coins in the treasure chest).
Before taking a cookie, call 'wait'. If there are no cookies left then wait will not return:
It will wait until another thread increments the semaphore by calling post.

In short, post increments and immediately returns whereas wait will wait if the count is zero.
Before returning it will decrement count.

First decide if the initial value should be zero or some other value (e.g. the number of remaining spaces in an array). Unlike pthread mutex there are not shortcuts to creating a semaphore - use sem_init

#include <semaphore.h>

sem_t s;
int main() {
  sem_init(&s, 0, 10); // returns -1 (=FAILED) on OS X
  sem_wait(&s); // Could do this 10 times without blocking
  sem_post(&s); // Announce that we've finished (and one more resource item is available; increment count)
  sem_destroy(&s); // release resources of the semaphore
}
Can I call wait and post from different threads?
Yes! Unlike a mutex, the increment and decrement can be from different threads.

Can I use a semaphore instead of a mutex?
Yes - though the overhead of a semaphore is greater. To use a semaphore:

Initialize the semaphore with a count of one.
Replace ...lock with sem_wait
Replace ...unlock with sem_post
A mutex is a semaphore that always waits before it posts

sem_t s;
sem_init(&s, 0, 1);

sem_wait(&s);
// Critical Section
sem_post(&s);
 */


/// Write a program that uses two threads to print the numbers from 1 to n.
func concurrentCounter(_ n: Int, _ numThreads: Int = 2) {
    var currentNumber = 0
    let semaphore = DispatchSemaphore(value: 1)
    let operationQueue = OperationQueue()
    operationQueue.maxConcurrentOperationCount = numThreads

    let counter: (inout Int) -> Void = { currentNumber in
        while true {
            semaphore.wait()
            

            if currentNumber > n {
                semaphore.signal()
                return
            }

            print(currentNumber)
            currentNumber += 1

            semaphore.signal()
        }
    }

    operationQueue.addOperation {
        counter(&currentNumber)
    }
    
    operationQueue.addOperation {
        counter(&currentNumber)
    }
}

concurrentCounter(25)
